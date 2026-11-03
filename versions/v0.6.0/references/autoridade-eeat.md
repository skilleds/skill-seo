# Autoridade, E-E-A-T e Off-Page (schematize-seo)

> Parte da skill **schematize-seo**. Governa a **disciplina de autoridade**: como a casa ganha confiança de busca e de resposta-de-IA off-page (backlinks, sinais de marca) e on-page (E-E-A-T, autoria real, entidade consistente). Táticas de conteúdo ficam em `keywords-conteudo.md`; o markup que prova autoria/entidade fica em `dados-estruturados.md`; a arquitetura cross-domain e a estratégia de link "que importa" ficam em `internacional-multidominio.md`; a filosofia e a lista completa de black-hat ficam em `anti-padroes.md`; como medir link/marca fica em `medicao.md`.

## Como ler

- **MUST / Obrigatório** — regra. Desvio bloqueia entrega ou exige ADR.
- **SHOULD / Recomendado** — padrão. Desvio precisa de justificativa.
- **MAY / Opcional** — sugestão.
- **VETADO / Proibido** — não existe atalho. Burlar é incidente, não decisão técnica. Não tem ADR de exceção.

> Autoridade não se compra nem se force. Ela é **consequência** de conteúdo que merece link e de uma entidade coerente em todos os domínios da casa. Atalho de autoridade (link comprado, PBN, esquema de troca) é o jeito mais rápido de **queimar** domínio — e domínio com autoridade é ativo caro de reconstruir (piso 1 da SKILL).

---

## 1. O que é autoridade e por que qualidade vence quantidade

Autoridade é o sinal, agregado, de que fontes independentes e confiáveis **apostam** no seu conteúdo — linkando, citando e mencionando a marca. Vale para rank em busca **e** para ser citado por answer engines (`aio-llmo-geo.md`).

**MUST — julgue todo backlink por qualidade, não por contagem.** Um link editorial de fonte relevante e autoritativa vale mais que centenas de links de baixo valor. Avalie por estes eixos:

| Eixo | Link forte | Link fraco / tóxico |
|---|---|---|
| **Relevância** | origem do mesmo tema/nicho | site aleatório, sem relação temática |
| **Autoridade da origem** | domínio com histórico e tráfego real | domínio novo, spam, PBN, granja de links |
| **Contexto** | dentro do corpo editorial, cercado de texto relevante | rodapé, sidebar, lista de "parceiros", comentário |
| **Tipo** | `dofollow` editorial ganho | pago não declarado, troca em esquema, autogerado |
| **Âncora** | natural (marca, URL, frase descritiva) | exata em keyword comercial, repetida em massa |
| **Diversidade** | perfil variado de domínios | muitos links do mesmo domínio/IP/rede |

**MUST — `nofollow`/`ugc`/`sponsored` não é fracasso.** Menção em veículo grande com `nofollow` ainda gera sinal de marca, tráfego e descoberta por IA. Não recuse cobertura por causa do atributo, e **nunca** peça a alguém pra remover `nofollow` de link pago (é o oposto do correto — link pago **deve** ser `sponsored`).

**VETADO** — perseguir volume de links (contagem como meta), comprar/alugar links, participar de esquema de troca recíproca, PBN, redes de blog, comentário-spam, link em rodapé site-wide comprado. Ver `anti-padroes.md`.

---

## 2. Como ganhar link de forma limpa

A única estratégia sustentável: **crie coisa que merece link** e depois facilite o link acontecer.

### 2.1 Ativos linkáveis (linkable assets)

**SHOULD — priorize construir ativos que atraem link naturalmente:**

| Ativo | Por que ganha link |
|---|---|
| **Dados originais / pesquisa** | número que ninguém mais tem vira citação obrigatória |
| **Ferramenta gratuita** | resolve tarefa; gente linka a ferramenta, não o texto |
| **Guia definitivo** | referência do tema; outros linkam em vez de reexplicar |
| **Open-source** | repo útil vira dependência e citação — o `.org` e a **schematize CLI** são motor natural disto (§5) |
| **Documentação de qualidade** | dev linka o doc que resolveu o problema dele |

### 2.2 Táticas de aquisição (todas white-hat)

- **Digital PR** — transforme dado original ou lançamento em pauta e ofereça a jornalistas/veículos do nicho. Link vem da cobertura editorial, ganho.
- **Guest content legítimo** — conteúdo genuíno e útil em veículo relevante, com bio real do autor. **VETADO** guest posting em massa só pra plantar âncora exata.
- **Parcerias e integrações** — co-marketing, integração técnica, estudo de caso conjunto; cada lado linka o outro por mérito real.
- **Menção não-linkada → link** — monitore menções à marca/produto (`medicao.md`) e peça, com educação, para transformar a menção textual em link. É o link de maior taxa de conversão e 100% limpo.
- **Link recuperado** — ache links quebrados que apontavam pra conteúdo morto (seu ou de terceiro) e ofereça o seu como substituto vivo.

**MUST** — todo pedido de link é **oferta de valor**, não súplica nem transação. Se a única razão pra alguém linkar é dinheiro ou reciprocidade forçada, não é link limpo.

---

## 3. E-E-A-T na prática

E-E-A-T (Experience, Expertise, Authoritativeness, Trust — **Trust é o centro**) não é meta-tag: é o conjunto de sinais de que **pessoas reais e competentes** estão por trás do conteúdo. Aplica a busca e, cada vez mais, a citação por IA (`aio-llmo-geo.md`).

**MUST — autoria real e verificável em todo conteúdo editorial:**
- Byline com **autor real** (pessoa, não "Equipe" genérico em conteúdo YMYL/técnico), com **bio, credenciais e link** para perfil/rede.
- Marque a autoria com **`Person` schema** ligado ao `Article`/`BlogPosting` (`author`), e o `Person` a `sameAs` (perfis oficiais). O markup exato está em `dados-estruturados.md`.
- **Experience** aparece no texto: primeira mão, exemplo próprio, resultado medido — não paráfrase de terceiros.

**MUST — sinais de confiança do site:**

| Sinal | Exigência |
|---|---|
| Página **Sobre** | quem é a casa, o que faz, quem são as pessoas |
| **Contato** real | forma de falar com gente de verdade |
| **Transparência** | política de conteúdo, correções, data de publicação **e** de atualização visíveis |
| **Citação de fontes** | link/atribuição a fontes primárias que sustentam afirmações |
| **Consistência de identidade** | mesmo nome, logo e descrição da entidade em todos os domínios (§4) |

**MUST — conteúdo mantido vivo.** Conteúdo que decai (dado velho, print antigo, versão obsoleta) perde E-E-A-T. Atualize e carimbe `dateModified` de verdade (não faça *fake refresh* — mudar a data sem mudar o conteúdo é enganação e some no primeiro spot-check). Cadência de refresh em `keywords-conteudo.md`.

**VETADO** — autoria fantasma/inventada, bio falsa, credencial não-verificável, conteúdo YMYL sem autoria qualificada, `dateModified` mentiroso.

---

## 4. Sinais de marca e consistência de entidade

Marca forte é sinal de autoridade: busca e IA reconhecem entidades, não só páginas.

**SHOULD — cultive os sinais de marca:**
- **Buscas pela marca** (branded search) sobem quando a marca é conhecida — resultado de conteúdo bom e PR, não de truque.
- **Menções** (com ou sem link) constroem a entidade; monitore-as (`medicao.md`).
- **Presença consistente** em perfis oficiais (GitHub org `schematizeme`, redes, diretórios do nicho), todos com o mesmo nome e descrição.

**MUST — entidade coerente cross-domain.** `.net`, `.org`, `.me` e `.com.br` são a **mesma entidade** vista de ângulos distintos. Nome, logo, descrição e `Organization`/`sameAs` schema batem entre si; os domínios se reconhecem via `sameAs` recíproco e links editoriais — **nunca** via canonical cruzado (piso 4 da SKILL). Como amarrar a entidade entre domínios está em `internacional-multidominio.md`; o `Organization`+`sameAs` está em `dados-estruturados.md`.

---

## 5. O ecossistema e o open-source como motor de autoridade

A casa tem uma vantagem estrutural: **open-source real** (a **schematize CLI** e os projetos do `.org`) e um blog (`blog.schematize.net`). Use-os como motor de link e de autoridade de entidade.

**SHOULD — opere o ecossistema assim:**

| Fonte | Papel na autoridade | Destino do valor |
|---|---|---|
| **schematize CLI / repos `.org`** | ativo linkável nº 1: dev linka repo/doc/ferramenta por utilidade | links editoriais + entidade forte |
| **blog.schematize.net** | dado original, guia definitivo, digital PR | atrai link e alimenta AIO |
| **GitHub org `schematizeme`** | prova de entidade e de atividade real | `sameAs` + credibilidade |
| **`.me` / `.com.br`** | conteúdo distinto por mercado/idioma | autoridade local própria |

**MUST — o fluxo de valor converge pro `.net` sem canibalizar.** Cada domínio é self-canonical e tem conteúdo próprio; os **"links que importam"** (o link editorial forte, o CTA de conversão) apontam pro domínio-âncora `.net`. Isso concentra autoridade **por link**, não por canonical. A regra completa de qual link vai pra onde está em `internacional-multidominio.md`.

**MUST — README/doc de repo público linka de volta** pro `.net` (e pro blog quando cabe) com âncora natural. Repo é superfície de descoberta; use-a.

---

## 6. Higiene de link tóxico e disavow

**MUST — não entre em pânico com link ruim.** O Google **ignora** a esmagadora maioria dos links de spam automaticamente. Link tóxico que você **não criou** raramente exige ação.

**SHOULD — audite o perfil de links** periodicamente (`medicao.md`) procurando: pico anômalo de links de um só nicho/idioma irrelevante, âncora exata em massa, rede de domínios batendo junto — sinais de **negative SEO** ou de dívida de uma tática antiga.

**Disavow — só como último recurso:**

| Situação | Ação |
|---|---|
| Links de spam que você não criou | **Não faça nada** — o Google ignora |
| Penalização manual por link (Search Console avisou) | Remova o que der + **disavow** o resto |
| Você (ou um fornecedor antigo) comprou/plantou links | Limpe: remova na origem e **disavow** o que sobrar |

**VETADO** — usar `disavow` por medo, sem penalização manual nem histórico de link comprado (você pode jogar fora link bom por engano). E **VETADO**, sempre: comprar, alugar ou trocar link em esquema, ou operar/usar PBN. Ver `anti-padroes.md`.

---

## 7. Anchor text natural

**MUST — perfil de âncora natural.** Um perfil saudável é dominado por âncoras de **marca**, **URL crua** e **frase descritiva/genérica** ("veja o guia", "nesta ferramenta"). Âncora de match exato em keyword comercial deve ser **minoria** e nunca forçada.

**VETADO** — engenharia de âncora: pedir a todo mundo a mesma âncora exata, plantar keyword comercial repetida em links externos. Padrão de âncora over-optimized é um dos gatilhos mais claros de esquema de link e derruba o domínio.

**SHOULD** — em link interno você controla a âncora: use-a descritiva e variada (isto é on-page, ver `on-page.md`); em link externo, você **não** controla — e é isso que o torna natural. Não tente controlar.

---

## Checklist de autoridade & E-E-A-T

Antes de dar por pronta qualquer entrega que toque autoridade, marca ou autoria:

**Backlinks e off-page**
- [ ] A meta é qualidade e relevância, não contagem de links
- [ ] Nenhum link comprado, alugado, trocado em esquema ou de PBN no plano
- [ ] Existe pelo menos um **ativo linkável** real por trás da aquisição (dado, ferramenta, guia, open-source)
- [ ] Táticas de aquisição são white-hat (digital PR, guest legítimo, parceria, menção→link, link recuperado)
- [ ] Menções não-linkadas da marca estão sendo monitoradas e convertidas
- [ ] Âncora externa é natural (marca/URL/descritiva domina; exata é minoria)

**E-E-A-T**
- [ ] Conteúdo editorial tem **autor real** com bio, credenciais e link
- [ ] Autoria marcada com **`Person` schema** ligado ao artigo (ver `dados-estruturados.md`)
- [ ] Existem páginas **Sobre** e **Contato** reais
- [ ] Fontes primárias citadas/linkadas onde há afirmação factual
- [ ] `datePublished`/`dateModified` visíveis e **verdadeiros** (sem fake refresh)
- [ ] Conteúdo que decai tem cadência de atualização (ver `keywords-conteudo.md`)

**Marca e entidade**
- [ ] Nome, logo e descrição consistentes em todos os domínios e perfis
- [ ] `Organization` + `sameAs` recíprocos entre os domínios da casa (ver `internacional-multidominio.md` e `dados-estruturados.md`)
- [ ] Repos públicos (schematize CLI / `.org`) linkam de volta pro `.net` com âncora natural
- [ ] Os "links que importam" convergem pro `.net` **por link**, nunca por canonical cruzado

**Higiene**
- [ ] Perfil de links auditado; nenhum sinal de negative SEO ignorado
- [ ] `disavow` só cogitado sob penalização manual ou dívida de link comprado — nunca por medo
- [ ] Sem padrão de âncora over-optimized em links externos
