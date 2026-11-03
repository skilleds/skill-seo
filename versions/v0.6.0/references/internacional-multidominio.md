# SEO Internacional e Multi-Domínio sem Canibalização

> Parte da skill **schematize-seo**. Este é o **reference central da estratégia de domínios da casa** — a decisão que rege como `schematize.net`, `schematize.org`, `schematize.me` e `schematize.com.br` coexistem, cada um como propriedade distinta, sem se canibalizar e sem jogar autoridade fora. Leia junto com `dados-estruturados.md` (entidade de marca cross-domain), `anti-padroes.md` (o veto ao canonical cruzado), `keywords-conteudo.md` (uma intenção por URL) e `on-page.md` (canonical/hreflang por página). A implementação (tags, sitemap, i18n com URL por idioma) delega ao **schematize-web** — aqui é a disciplina; lá, o código.

## Índice
- 1. Como ler
- 2. O erro que este arquivo existe para impedir
- 3. Anatomia dos domínios: ccTLD, gTLD e vanity/brandable
- 4. A estratégia da casa: 4 propriedades distintas por propósito
- 5. Por que NUNCA canonicalizar .me/.com.br → .net
- 6. Como evitar canibalização sem canonical cruzado
- 7. hreflang: quando, sintaxe e o que invalida
- 8. Matriz de decisão: hreflang vs propriedades independentes
- 9. Estratégia de links: consolidar a marca, converter no .net
- 10. Migração e redirect: quando o .me "virar" o .net
- 11. Entidade única de marca cross-domain
- 12. Pitfalls clássicos
- 13. Checklist multi-domínio

---

## 1. Como ler

- **MUST** — regra. Desvio exige ADR.
- **VETADO** — piso. Não tem ADR de exceção. Burlar é incidente, não decisão técnica.

Conflito real entre este documento e o problema → registre um ADR. Itens VETADO não têm exceção: canonicalizar uma propriedade de alta autoridade para outra queima anos de sinal, e sinal de domínio é o ativo mais caro de reconstruir.

---

## 2. O erro que este arquivo existe para impedir

A tentação, quando se tem 4 domínios e um "principal", é apontar tudo pro principal via `rel=canonical` — "pra concentrar a força no `.net`". **Isso está errado e é VETADO.** O canonical não *transfere* autoridade pro alvo: ele diz ao Google "essa página é uma cópia daquela, ignore esta". O resultado é que o `.me` (que hoje tem ALTA autoridade) sai do índice, seus backlinks passam a apontar pra uma URL que se declara duplicata, e a casa **perde** o ativo em vez de somar.

A regra da casa: **4 domínios = 4 propriedades distintas, cada uma self-canonical, cada uma com conteúdo próprio, conectadas por links — nunca por canonical cruzado.** A concentração de força comercial acontece por **arquitetura de links** (os "links que importam" apontam pro `.net`), não por canonicalização.

---

## 3. Anatomia dos domínios: ccTLD, gTLD e vanity/brandable

Cada tipo de TLD emite sinais diferentes pro buscador. Conheça o que cada um diz *antes* de decidir o papel de cada domínio.

| Tipo | Exemplo da casa | Sinal geográfico | Sinal de propósito | Uso correto |
|---|---|---|---|---|
| **ccTLD** (country-code) | `schematize.com.br` | **Forte e automático**: `.com.br` grita "Brasil" pro Google, restringe/prioriza o país | Genérico ("comércio no BR") | Mercado de um país específico, idioma local, conteúdo próprio pra aquele mercado |
| **gTLD** (generic) | `schematize.net`, `schematize.org` | **Neutro**: sem país embutido; geo vem de conteúdo/links/GSC (targeting) | `.net`/`.com` = comercial; `.org` = institucional/sem-fins/pesquisa (convenção, não regra técnica) | Alcance global; papel definido pelo conteúdo e pela convenção do TLD |
| **Vanity/brandable** | `schematize.me` | **Neutro** (`.me` é ccTLD de Montenegro, mas o Google trata como gTLD genérico) | Marca/global, memorável | Marca-mãe, hub de autoridade, conteúdo próprio que rankeia no nicho |

**MUST**
- **`.com.br` só carrega conteúdo pt-BR pro mercado brasileiro.** É o sinal geográfico mais forte que a casa tem; desperdiçá-lo com conteúdo global genérico é jogar fora vantagem de ranking no BR.
- **Não existe mais *targeting* geográfico no Google Search Console.** ✔ Verificado em 2026-08-21: o relatório *International Targeting* foi **desativado em 2022** — prescrevê-lo como **MUST** era prescrever um botão que não existe, e um MUST inexequível é pior que nenhum, porque ensina o time a ignorar MUSTs. O sinal de geo para um gTLD (`.net`, `.org`) vem hoje de: **hreflang recíproco** (com `x-default`), **idioma e moeda do conteúdo**, **endereço/telefone reais na página** (marcados em `Organization`/`LocalBusiness`), e **links locais**. `.org` segue a convenção institucional/informacional — o Google não força, mas usuários e linkadores esperam isso, e a casa honra.
- **`.me` é tratado como genérico** — não conte com sinal geográfico dele; sua força vem de autoridade acumulada e conteúdo de nicho.

---

## 4. A estratégia da casa: 4 propriedades distintas por propósito

Este é o coração. Memorize a tabela — ela é a fonte da verdade de papel, intenção, idioma, canonical, hreflang e link de cada domínio.

| Domínio | Propósito | Intenção-alvo | Idioma | Canonical | hreflang | Papel de link |
|---|---|---|---|---|---|---|
| **schematize.net** | **Comercial** — produto (CLI schematize p/ esquematizar agentes de IA), consultoria, cursos, softwares | **Transacional/comercial**: comprar, contratar, instalar, assinar | en (global) | **Self** | Com `.com.br`/`.me` **só** se for a MESMA página traduzida (raro aqui) | **DOMÍNIO-ÂNCORA**: recebe os "links que importam" (comprar/contratar/instalar) das outras 3 |
| **schematize.org** | **Institucional/informacional** — projetos open-source, pesquisa, laboratório | **Informacional**: entender, pesquisar, contribuir, ler docs de projeto | en (global) | **Self** | Self salvo tradução 1:1 | Emite links contextuais dofollow pro `.net` (produto) e cita `.me`; recebe links de pesquisa |
| **schematize.me** | **Marca/global** — hub da marca, ALTA autoridade hoje | **Navegacional/marca + nicho**: quem é a schematize, autoridade no tema | en (global) | **Self** (NUNCA → `.net`) | Self; se houver par pt-BR traduzido 1:1 no `.com.br`, hreflang recíproco | Consolida a marca; **linka contextualmente pro `.net`** nos CTAs de conversão |
| **schematize.com.br** | **Mercado brasileiro** — conteúdo pt-BR próprio | **Todas as intenções, no BR e em pt-BR** | pt-BR | **Self** (NUNCA → `.net`) | Self; se for tradução 1:1 do `.me`/`.net`, hreflang recíproco com eles | Converte o público BR: CTAs de conversão apontam pro `.net` (ou pra checkout/BR próprio quando existir) |

**MUST**
- **Cada propriedade é self-canonical.** `rel=canonical` de toda página aponta pra ela mesma (URL absoluta, https, versão única de www).
- **Cada propriedade carrega conteúdo PRÓPRIO** — não é espelho, não é redirect, não é o mesmo HTML servido em 4 URLs. Se dois domínios servem o mesmo texto sem propósito distinto, um deles é ruído que canibaliza o outro.
- **O papel de cada domínio é registrado em ADR** e não muda ao sabor da tarefa. "Coloca isso no `.me` que é mais rápido" não revoga a arquitetura.

**VETADO**
- Duplicar a home (ou qualquer página) nos 4 domínios com o mesmo conteúdo. Ver §12.
- Redirecionar `.me`/`.com.br` pro `.net` "porque o `.net` é o principal". Hoje é o `.me` que "vira" o `.net` no sentido de **encaminhar conversão por link** — não por redirect nem canonical.

---

## 5. Por que NUNCA canonicalizar .me/.com.br → .net

**VETADO — canonical cruzado entre domínios distintos da casa.** Este é anti-padrão explícito (ver `anti-padroes.md`).

O `rel=canonical` cross-domain diz ao Google: "esta página é uma versão duplicada daquela; indexe a outra". Consequências de apontar `.me` → `.net`:

1. **O `.me` sai do índice.** A página que tinha autoridade deixa de rankear com URL própria.
2. **A autoridade não "migra limpa".** O canonical é uma *dica*, não um 301; o Google pode consolidar sinais, mas o histórico, os backlinks apontando pro `.me` e a relevância de nicho do `.me` são desperdiçados ou diluídos.
3. **Você troca um ativo maduro por uma aposta.** O `.me` tem ALTA autoridade HOJE. Canonicalizá-lo é abrir mão de valor real por um ganho hipotético no `.net`.
4. **O mercado BR some.** Canonicalizar `.com.br` → `.net` mata o sinal geográfico ccTLD e o ranking pt-BR — o pior desperdício da lista.

A força comercial se concentra no `.net` por **links** (§9), não por canonical. O canonical cruzado só é legítimo quando o conteúdo é genuinamente a MESMA página e uma URL vai ser aposentada — aí o instrumento certo é **301** (§10), não canonical.

---

## 6. Como evitar canibalização sem canonical cruzado

Se não se canonicaliza, como impedir que `.net`, `.org`, `.me` e `.com.br` disputem as mesmas queries? **Diferenciando por INTENÇÃO, CONTEÚDO, IDIOMA e MERCADO** — não por canonical.

**MUST — quatro eixos de diferenciação:**

| Eixo | Como aplicar | Efeito |
|---|---|---|
| **Intenção** | `.net` = transacional; `.org` = informacional/pesquisa; `.me` = marca/nicho; `.com.br` = todas, no BR | Cada domínio rankeia queries diferentes; não competem |
| **Conteúdo** | Cada domínio tem texto, ângulo e profundidade próprios sobre o tema | Google não vê duplicata; cada URL tem valor único |
| **Idioma** | `.com.br` = pt-BR; os demais = en | Segmenta por idioma da query |
| **Mercado** | `.com.br` = Brasil; `.net`/`.org`/`.me` = global (targeting no GSC quando preciso) | Segmenta por geografia |

**A regra "uma intenção por URL" (piso da skill) vale também entre domínios.** Duas páginas da casa — mesmo em domínios diferentes — mirando a MESMA intenção na MESMA língua e mercado é canibalização. Resolva: consolide numa só, diferencie o ângulo/intenção, ou (se uma vai morrer) 301. Ver `keywords-conteudo.md`.

**Sinal de que canibalizou:** no Search Console, a mesma query traz impressões alternando entre duas URLs da casa, ambas com posição instável. Duas páginas nossas brigando entre si empurram as duas pra baixo.

---

## 7. hreflang: quando, sintaxe e o que invalida

`hreflang` serve **um único caso**: a **MESMA página, traduzida** em idiomas/regiões diferentes. Ele diz ao Google "estas URLs são a mesma coisa em línguas diferentes; sirva a certa pra cada usuário". **Não** é ferramenta pra páginas de conteúdo distinto — essas são propriedades independentes, self-canonical, sem hreflang entre si.

**MUST — quando usar hreflang**
- Só quando `.com.br` (pt-BR) e `.me`/`.net` (en) servem **a mesma página traduzida 1:1** (mesmo propósito, mesmo conteúdo, só a língua muda). Aí sim: hreflang recíproco entre elas.
- **Não** use hreflang quando o conteúdo é distinto por mercado/propósito — mesmo que trate do mesmo tema. Conteúdo distinto = páginas independentes (§8).

**Sintaxe (MUST):**
- No `<head>` de cada página do conjunto, ou no sitemap (`xhtml:link`), ou header HTTP. Um método, consistente.
- Cada página lista **todas** as alternativas do conjunto, **incluindo a si mesma** (auto-referência):
  ```html
  <link rel="alternate" hreflang="pt-BR" href="https://schematize.com.br/pagina" />
  <link rel="alternate" hreflang="en"    href="https://schematize.me/page" />
  <link rel="alternate" hreflang="x-default" href="https://schematize.me/page" />
  ```
- **`x-default` obrigatório** — a URL de fallback pra quem não casa com nenhum idioma/região listado.
- **Reciprocidade TOTAL**: se A aponta pra B, B tem que apontar pra A. hreflang unilateral é ignorado.
- Valores BCP-47: `pt-BR`, `en`, `en-US`, `es-419`. Idioma minúsculo, região maiúscula. `pt_BR` (underscore) é inválido.
- A URL em `hreflang` deve ser **indexável** — nada de apontar pra página `noindex`, 404 ou redirect.

**O que INVALIDA o hreflang (o Google ignora o conjunto inteiro):**

| Erro | Por que quebra |
|---|---|
| Falta a auto-referência | Conjunto incompleto; Google descarta |
| Falta `x-default` | Sem fallback declarado (não invalida sozinho, mas é MUST da casa) |
| Não é recíproco (A→B, B↛A) | Google exige confirmação dos dois lados |
| Código de idioma malformado (`pt_BR`, `PT-br`, `en_gb`) | Valor inválido é ignorado |
| Aponta pra URL `noindex`/404/redirect | Alvo não indexável invalida a entrada |
| hreflang + canonical brigando (canonical aponta pra outra URL do conjunto) | Sinais contraditórios; Google se confunde. Cada página do conjunto é **self-canonical** e usa hreflang pras irmãs |

**Piso (ver SKILL): hreflang recíproco e completo, com `x-default`, sempre que houver variação por idioma/região.**

---

## 8. Matriz de decisão: hreflang vs propriedades independentes

A pergunta que decide tudo: **é a mesma página traduzida, ou é conteúdo distinto?**

| Situação | É... | Instrumento | Canonical | hreflang |
|---|---|---|---|---|
| `.com.br` pt-BR e `.me` en são o **MESMO conteúdo traduzido** (mesma página, só a língua muda) | Tradução 1:1 | **hreflang** recíproco + `x-default` | Cada uma **self** | **Sim**, entre elas |
| `.com.br` tem conteúdo pt-BR **próprio pro mercado BR**; `.me` tem conteúdo global de marca | Propriedades distintas | **Interlink** contextual (links dofollow) | Cada uma **self** | **Não** |
| `.net` (comprar produto) e `.org` (docs do projeto open-source) sobre o mesmo tema | Intenções distintas | **Interlink** contextual | Cada uma **self** | **Não** |
| Duas páginas nossas, MESMA intenção, MESMA língua, MESMO mercado | Canibalização | Consolidar / diferenciar / **301** | A que fica: self | N/A |
| Uma URL vai ser **aposentada** e substituída por outra | Migração | **301** 1:1 | A nova: self | N/A |

**Regra de bolso:** se você traduziu → hreflang. Se você escreveu conteúdo diferente pra um propósito/mercado diferente → propriedades independentes + interlink. Se são a mesma coisa competindo → conserte a canibalização. Se uma vai morrer → 301. **Canonical cruzado nunca entra nesta tabela** entre domínios distintos.

---

## 9. Estratégia de links: consolidar a marca, converter no .net

O que substitui o canonical na "concentração de força" é a **arquitetura de links internos entre os domínios da casa**.

**MUST**
- **Conversão sempre aponta pro `.net`.** Todo CTA de comprar/contratar/instalar/assinar — venha do `.org`, do `.me` ou do `.com.br` — leva pro `schematize.net` (ou pro checkout/fluxo comercial dele). O `.net` é o funil de conversão da casa.
- **`.org`, `.me` e `.com.br` interligam por links contextuais dofollow.** São a mesma casa; não há `nofollow` entre propriedades próprias. O link é contextual (dentro do conteúdo, com âncora descritiva), não um rodapé de "nossos outros sites".
- **Âncoras descritivas e verdadeiras.** Link pro `.net` com âncora que descreve o destino ("instale o CLI schematize"), não "clique aqui".
- **Fluxo de link da casa:**
  - `.org` (pesquisa/docs) → cita e linka o `.net` (produto) e o `.me` (marca).
  - `.me` (marca/autoridade) → CTAs pro `.net`; referencia `.org` pra profundidade.
  - `.com.br` (BR) → CTAs pro `.net` (ou fluxo BR); linka `.me`/`.org` quando agrega.
  - `.net` (comercial) → linka `.org`/`.me` pra prova/autoridade/documentação.

**Efeito:** o Google vê 4 propriedades fortemente interligadas, tematicamente coerentes, com a conversão convergindo pro `.net` — sem que nenhuma abra mão da própria autoridade. A marca vira uma **entidade** (§11), não 4 sites soltos nem 4 duplicatas.

---

## 10. Migração e redirect: quando o .me "virar" o .net

Hoje o `.me` "vira" o `.net` no sentido de **encaminhar conversão por link**, não por redirect. Se um dia a decisão for de fato **aposentar** uma URL (ou consolidar uma propriedade na outra), o instrumento é o **301** — nunca o canonical, nunca o redirect cego em massa.

**MUST — migração sem perder autoridade:**
- **301 mapeado 1:1.** Cada URL antiga redireciona pra sua correspondente exata na nova, com o conteúdo equivalente. **Nunca** redirecionar tudo pra home — redirect em massa pra raiz é tratado como soft-404 e perde o sinal.
- **301 (permanente), não 302.** O 302 (temporário) não passa autoridade de forma consolidada.
- **Só migre o que vai realmente morrer.** Se as duas propriedades continuam com conteúdos distintos e propósitos distintos, **mantenha as duas vivas** — não redirecione. Redirect é pra aposentadoria, não pra "juntar força".
- **Preserve o conteúdo no destino.** A URL de destino do 301 tem que ter conteúdo equivalente ou superior; redirecionar pra página vazia ou genérica perde ranking.
- **Sequência de migração:** (1) baseline no GSC (posições, backlinks, páginas indexadas — ver `medicao.md`); (2) publica destino com conteúdo pronto; (3) 301 mapeado 1:1; (4) atualiza sitemaps e internal links pra apontar direto ao destino (evita cadeia de redirect); (5) mantém os 301 no ar por tempo longo (meses/anos — backlinks demoram a atualizar); (6) monitora GSC até os sinais migrarem.
- **Change of Address no GSC** quando a migração for de site/domínio inteiro.
- **Evite cadeias e loops de redirect** (A→B→C). Aponte direto pro destino final.

**VETADO**
- Substituir migração por `rel=canonical` cross-domain (é dica, não transferência — §5).
- Redirect em massa pra home. Perde autoridade das páginas internas.
- Aposentar uma propriedade de alta autoridade sem baseline e sem 301 1:1.

---

## 11. Entidade única de marca cross-domain

Pro Google entender que os 4 domínios são a **mesma casa** — sem tratá-los como duplicatas — a marca tem que se apresentar como **uma entidade consistente** em todos. Isto liga diretamente a `dados-estruturados.md`.

**MUST**
- **`Organization` idêntico em todos os domínios** (JSON-LD): mesmo `name`, mesmo `logo`, mesma descrição de entidade. Ver `dados-estruturados.md` para o schema.
- **`sameAs` cruzado e consistente.** O `Organization` de cada domínio lista, em `sameAs`, as outras propriedades da casa **e** os perfis sociais oficiais (GitHub `schematizeme`, LinkedIn, etc.). Isso diz ao Google "estas URLs são facetas da mesma entidade".
  ```json
  {
    "@type": "Organization",
    "name": "schematize",
    "url": "https://schematize.net",
    "sameAs": [
      "https://schematize.org",
      "https://schematize.me",
      "https://schematize.com.br",
      "https://github.com/schematizeme"
    ]
  }
  ```
- **Mesmos perfis sociais oficiais** referenciados por todos os domínios — um conjunto, não perfis divergentes por site.
- **A âncora da entidade é o `.net`, e isto é a FONTE ÚNICA da regra.** O `@id` e o `url` do
  `Organization` apontam para o **`.net`** como URL canônica da entidade, mesmo quando o markup é
  servido a partir do `.org`/`.me`/`.com.br`; os outros três entram em **`sameAs`**. Isso reforça o
  `.net` como face comercial **sem** canonicalizar as páginas (o canonical de cada página continua
  self — ver o VETADO do canonical cruzado). *`dados-estruturados.md` apontava `.org` como âncora;
  duas âncoras escritas em dois lugares fazem o buscador ver **duas organizações** com o mesmo nome,
  e a autoridade que deveria somar se divide. Corrigido em 2026-08-21: a definição mora aqui.*
- **Nome, logo, tom e identidade visual consistentes** nas 4 propriedades. Entidade é reconhecida por consistência.

**Efeito:** o Google monta um knowledge graph único da marca `schematize`, atribui a autoridade das 4 propriedades à mesma entidade, e entende a rede de links como coesão de marca — **sem** confundir as páginas distintas com duplicatas (o que exigiria canonical, que a casa não usa entre domínios).

---

## 12. Pitfalls clássicos

**VETADO**
- **Home duplicada nos 4 domínios.** Servir a mesma home em `.net`/`.org`/`.me`/`.com.br` é canibalização pura: 4 páginas brigando pela mesma query de marca, nenhuma com conteúdo próprio. **Cada home tem proposta e conteúdo distintos**: `.net` = "instale/contrate"; `.org` = "explore os projetos open-source e a pesquisa"; `.me` = "a marca schematize"; `.com.br` = "schematize no Brasil, em pt-BR". Ver §4.
- **Canonical cruzado** entre domínios distintos (§5).
- **Redirecionar `.me`/`.com.br` → `.net`** enquanto eles têm conteúdo próprio e autoridade (§5, §10).
- **hreflang entre conteúdos distintos** (só serve pra tradução 1:1 — §7, §8).
- **Redirect em massa pra home** numa migração (§10).
- **`Organization`/`sameAs` divergente** por domínio (quebra a entidade única — §11).

Outros erros comuns (corrija, não são piso, mas custam ranking):
- Confiar em sinal geográfico do `.net`/`.org`/`.me` sem targeting no GSC — TLD genérico não tem geo.
- Desperdiçar o `.com.br` (ccTLD, sinal BR forte) com conteúdo global genérico.
- `nofollow` entre propriedades da casa — são a mesma casa, o link é dofollow contextual.
- Interlink só no rodapé ("nossos outros sites") em vez de contextual no conteúdo.
- Cadeia de redirect (A→B→C) numa migração; aponte direto ao destino.

---

## 13. Checklist multi-domínio

Rode antes de publicar/alterar qualquer coisa que toque mais de um domínio da casa.

- [ ] Cada domínio (`.net`/`.org`/`.me`/`.com.br`) tem **propósito, intenção-alvo e conteúdo PRÓPRIOS** definidos (§4) e registrados em ADR.
- [ ] **Toda página é self-canonical** (URL absoluta, https, versão única de www) — em todos os domínios.
- [ ] **Zero canonical cruzado** entre os domínios distintos da casa (§5).
- [ ] **Nenhum redirect** `.me`/`.com.br` → `.net` enquanto essas propriedades têm conteúdo e autoridade próprios (§5, §10).
- [ ] A **home de cada domínio é distinta** em proposta e conteúdo — não é a mesma home replicada (§12).
- [ ] Diferenciação verificada nos 4 eixos (**intenção, conteúdo, idioma, mercado**) — sem duas páginas nossas na mesma intenção/língua/mercado (§6).
- [ ] Checado no GSC que **nenhuma query alterna entre duas URLs da casa** (sinal de canibalização — §6).
- [ ] **`.com.br` só serve conteúdo pt-BR** pro mercado BR; sinal ccTLD preservado (§3).
- [ ] **Sinais de geo** para os gTLDs quando o público é regional — hreflang recíproco + `x-default`, idioma/moeda do conteúdo, endereço e telefone reais marcados, links locais (§3). *(Não há mais o targeting do GSC: desativado em 2022.)*
- [ ] hreflang usado **só** onde há tradução 1:1 (§7, §8); onde é conteúdo distinto, **não** há hreflang, há interlink.
- [ ] Onde há hreflang: **recíproco, com auto-referência, `x-default`, códigos BCP-47 válidos, alvos indexáveis**, sem brigar com o self-canonical (§7).
- [ ] **CTAs de conversão apontam pro `.net`** (domínio-âncora) a partir de `.org`/`.me`/`.com.br` (§9).
- [ ] **Interlink contextual dofollow** entre as propriedades (no conteúdo, âncora descritiva — não só rodapé, nunca `nofollow`) (§9).
- [ ] **`Organization` idêntico** nos 4 domínios, com **`sameAs` cruzado** (as 4 URLs + perfis sociais oficiais) e `url` da entidade no `.net` (§11; ver `dados-estruturados.md`).
- [ ] Nome, logo, identidade e perfis sociais **consistentes** nas 4 propriedades (§11).
- [ ] Se houver migração/aposentadoria: **301 mapeado 1:1**, baseline no GSC antes, destino com conteúdo pronto, sitemaps/internal links atualizados, sem cadeia/loop, sem redirect pra home (§10; ver `medicao.md`).
- [ ] Nenhum item VETADO deste arquivo presente no diff (§5, §12).

> Regra suprema deste arquivo: **conteúdo distinto conecta por link; tradução 1:1 conecta por hreflang; URL aposentada conecta por 301. Canonical cruzado entre domínios distintos da casa, nunca.** A força comercial converge no `.net` por links — sem que `.me`, `.org` e `.com.br` abram mão da própria autoridade.
