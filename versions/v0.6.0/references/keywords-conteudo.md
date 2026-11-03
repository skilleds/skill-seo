# Keywords e Conteúdo — Pesquisa, Mapa por Intenção, Clusters, Briefs e Anti-Canibalização

> Parte da skill **schematize-seo**. Governa a **disciplina** de o que escrever, pra que intenção, em qual URL e em qual domínio — sem canibalizar dentro da propriedade nem entre os 4 domínios da casa. A **estratégia técnica** de crawl/index/canonical está em `tecnico.md`; a de multi-domínio e hreflang em `internacional-multidominio.md`; on-page (title/H1/URL) em `on-page.md`; a fundação (intenção, E-E-A-T, funil) em `fundamentos.md`; a lista de anti-padrões em `anti-padroes.md`. A **implementação** (rotas, `metadata`, sitemap) delega ao `schematize-web`.

## Como ler

- **MUST / Obrigatório** — regra. Desvio bloqueia publicação ou exige ADR.
- **SHOULD / Recomendado** — padrão. Desvio precisa de justificativa registrada.
- **MAY / Opcional** — sugestão.
- **VETADO** — piso. Não tem "atalho", não tem exceção por ADR.

Conteúdo é ativo de SEO: cada peça consome autoridade, budget de crawl e atenção do leitor. Peça sem intenção clara, sem keyword mapeada e sem domínio definido **não se publica**.

## Índice
- 1. Pesquisa de keywords
- 2. Mapa por intenção (keyword → URL → intenção)
- 3. Topic clusters e pillar pages
- 4. Briefs de conteúdo
- 5. Anti-thin e anti-duplicado
- 6. Canibalização — detectar e resolver
- 7. Cadência de refresh (historical optimization)
- 8. Distribuição por domínio (net/org/me/com.br)
- 9. Checklist

---

## 1. Pesquisa de keywords

**MUST**
- Toda peça de conteúdo nasce de uma **keyword primária** identificada por pesquisa — nunca de "achei que seria legal escrever sobre X".
- Começar por **seed keywords** (os termos-núcleo do negócio: `esquematizar agentes de IA`, `CLI para agentes`, `padrões de engenharia com IA`) e **expandir**: variações, perguntas, modificadores (`como`, `melhor`, `vs`, `preço`, `tutorial`), termos correlatos e o vocabulário real do público.
- Avaliar cada candidata por **três eixos**, sempre juntos — nunca só volume:

| Eixo | O que é | Como usar |
|---|---|---|
| **Volume** | busca mensal estimada | ordem de grandeza, não número exato; compara termos entre si |
| **Dificuldade** | força dos concorrentes que já rankeiam | alta demais = escolher long-tail relacionada primeiro |
| **Intenção** | o que o usuário quer (informacional/comercial/transacional/navegacional) | decide o **tipo** de página e o **domínio** (§8) |

- Priorizar **long-tail** (3+ palavras, específica) no início e para autoridade nova: menos volume por termo, mas menor dificuldade, intenção mais clara e melhor conversão. A soma da cauda longa supera o head.
- **Ferramentas de forma agnóstica** — o método vale independente da ferramenta:

| Fonte | Serve pra |
|---|---|
| **Google Search Console** (GSC) | queries reais que **já** trazem impressão/clique — a fonte mais honesta de intenção do seu público |
| Keyword Planner / equivalente | volume e ideias de expansão a partir de seed |
| Autocomplete / "pessoas também perguntam" / buscas relacionadas | perguntas e long-tail reais, de graça |
| SERP da própria query | ver que **tipo** de página o buscador já premia (aquilo é a intenção validada) |

**SHOULD**
- Ler a SERP antes de decidir o formato: se o top-10 é tutorial, sua página comercial não vai rankear ali — a intenção manda.
- Registrar volume/dificuldade como faixa (alto/médio/baixo), não como número frágil de uma ferramenta específica.

**VETADO**
- Escolher keyword só por volume alto, ignorando dificuldade e intenção — gera página que nunca sai da página 3.

---

## 2. Mapa por intenção (keyword → URL → intenção)

**MUST**
- Manter uma **planilha-mapa** viva, fonte da verdade do conteúdo, com no mínimo:

| Coluna | Conteúdo |
|---|---|
| Keyword primária | UMA por URL |
| Keywords secundárias | variações/sinônimos que a mesma página cobre |
| Intenção | informacional / comercial / transacional / navegacional |
| URL | destino canônico (uma URL por linha primária) |
| Domínio | net / org / me / com.br (§8) |
| Status | planejada / publicada / a refazer / a consolidar |
| Métrica | posição/clique/impressão atual (liga com `medicao.md`) |

- **Uma keyword primária por URL. Uma URL por keyword primária.** Duas URLs mirando a mesma primária = canibalização (§6): resolver antes de publicar.
- Secundárias são as que **cabem na mesma intenção** — se uma "secundária" tem intenção diferente, ela é **primária de outra página**, não secundária desta.
- O mapa é pré-requisito de qualquer brief (§4): não se escreve sem a linha existir.

**SHOULD**
- Revisar o mapa a cada ciclo de refresh (§7) cruzando com o GSC pra flagrar canibalização emergente (§6).

**VETADO**
- Publicar página sem linha no mapa. Conteúdo órfão canibaliza e some do controle de qualidade.

---

## 3. Topic clusters e pillar pages

**MUST**
- Organizar o conteúdo em **topic clusters**: uma **pillar page** abrangente sobre o tema amplo + várias **cluster pages** específicas, cada uma cobrindo uma subintenção.
- **Linkar todo cluster de volta ao pillar** e o pillar aos clusters (internal linking bidirecional dentro do cluster) — é isso que constrói **topical authority** e distribui sinal.
- A pillar mira a keyword **head/ampla** (mais volume, mais dificuldade); cada cluster mira uma **long-tail** específica (§1). Cada uma continua com **uma** intenção (§2) — pillar não é um amontoado de tudo.

| Camada | Mira | Exemplo (tema "agentes de IA") |
|---|---|---|
| Pillar | keyword ampla, intenção guarda-chuva | "esquematizar agentes de IA" (guia completo) |
| Cluster | long-tail, subintenção específica | "como versionar skills de agente", "padrões de tool-use", "MAPA de endpoints pra agente" |

**SHOULD**
- Um cluster por área de dor do público; não inflar com clusters de temas que o domínio não deve cobrir (§8).
- Âncora interna descritiva (a keyword da página-destino), nunca "clique aqui" (liga com `on-page.md`).

**VETADO**
- Cluster que não linka pro pillar (ou vice-versa) — vira conteúdo solto sem topical authority.
- Duas pillars competindo pelo mesmo tema no mesmo domínio (§6).

---

## 4. Briefs de conteúdo

> **A redação do texto a partir do brief é da `schematize-seo-writing`** (4 passos, briefing por seção, checador executável; `/seow-write`). Este §4 define o brief no nível da peça e da URL; lá ele vira estrutura, briefings por seção e texto.

**MUST** — todo conteúdo novo ou refeito começa por um **brief** com, no mínimo:

| Campo | Conteúdo |
|---|---|
| **Intenção** | o que o usuário quer ao buscar — decide formato e profundidade |
| **Keyword primária** | a do mapa (§2) |
| **Keywords secundárias** | as que cabem na mesma intenção |
| **Perguntas a responder** | do "pessoas também perguntam", GSC, SERP — a página tem que respondê-las de fato |
| **Entidades** | pessoas, produtos, conceitos e termos que precisam aparecer (liga com E-E-A-T em `autoridade-eeat.md` e entidade em `aio-llmo-geo.md`) |
| **Tamanho-alvo** | por cobertura da intenção, **não** contagem de palavra por si só |
| **Links internos** | pro pillar/clusters e páginas relacionadas (§3); e o **CTA de conversão** apontando ao `.net` quando o domínio de origem não converte (§8) |
| **CTA** | a ação pretendida, coerente com a intenção e o domínio |

**SHOULD**
- Definir no brief o **ângulo** que diferencia a peça do que já rankeia (o que a SERP atual **não** entrega bem).
- Marcar os trechos candidatos a **extração por IA** (resposta direta, definição, passo-a-passo, tabela) — ver `aio-llmo-geo.md`.

**VETADO**
- Tamanho-alvo tratado como cota de palavras a encher — inchar texto pra "bater X mil palavras" gera thin disfarçado (§5).

---

## 5. Anti-thin e anti-duplicado

**MUST**
- Toda página **responde de fato** à intenção — cobre o assunto melhor ou diferente do que já está no top. Conteúdo raso ("thin"), que só toca a superfície, não rankeia e queima crawl budget.
- **Consolidar thin**: várias páginas fracas sobre o mesmo tema viram **uma** página forte (301 das demais pra ela — ver `tecnico.md`). Melhor uma página que responde tudo do que cinco que respondem nada.
- **Nunca duplicar conteúdo**:
  - **entre páginas do mesmo domínio** — duplicata canibaliza e dilui (§6);
  - **entre os domínios da casa** — `.net`, `.org`, `.me`, `.com.br` têm **conteúdo distinto** por design; publicar o mesmo texto em dois domínios é duplicação cross-domain que faz um afogar o outro. Cada domínio trata o tema pelo **seu** ângulo (§8).
- Tradução **não** é duplicação: pt-BR vs en é conteúdo por locale, resolvido com **hreflang recíproco** (ver `internacional-multidominio.md`), nunca com canonical cruzado.

**SHOULD**
- Antes de escrever, buscar no site se o tema já existe — se existe, **melhora a página que existe** (§7) em vez de criar concorrente interna.

**VETADO**
- Reaproveitar o mesmo texto em `.me` e `.com.br` "porque dá trabalho reescrever". É duplicação cross-domain (§8, `anti-padroes.md`).
- Spin/geração em massa de variações rasas pra "cobrir mais keywords" — black-hat, queima domínio (`anti-padroes.md`).

---

## 6. Canibalização — detectar e resolver

Canibalização = **duas ou mais URLs da mesma propriedade disputando a mesma query/intenção**. O buscador não sabe qual premiar, alterna entre elas, e nenhuma sobe. É o erro de conteúdo mais comum e mais silencioso.

**MUST — detectar**
- Via **GSC**: para uma query relevante, ver **quais URLs recebem impressão/clique**. Mais de uma URL sua aparecendo para a mesma query = sinal de canibalização.
- Sintomas: posição que oscila, URL "errada" rankeando pra query, CTR baixo apesar de impressão, duas páginas no mapa (§2) com a mesma primária.

**MUST — resolver** (escolher a saída certa, não a mais rápida):

| Situação | Saída |
|---|---|
| Duas páginas dizem quase o mesmo | **Consolidar**: fundir na melhor, **301** da outra (`tecnico.md`) |
| As duas têm valor, mas intenções próximas | **Diferenciar**: reescrever cada uma pra uma intenção distinta e separar as keywords no mapa (§2) |
| Uma é claramente obsoleta/fraca | **301** pra atual |
| Página secundária rouba a query da principal | **De-optimize** a secundária: remover a keyword do title/H1/âncoras dela e reforçar a principal |

**SHOULD**
- Após resolver, atualizar o mapa (§2) e registrar baseline/depois (`medicao.md`) — canibalização "resolvida" sem medição volta.

**VETADO**
- "Deixar as duas e ver qual ganha" — ambas perdem. Também VETADO usar **canonical cruzado entre domínios** da casa pra "resolver" (isso não é canibalização entre domínios; conteúdo distinto por domínio é a solução — §8, piso da SKILL).

---

## 7. Cadência de refresh (historical optimization)

**MUST**
- Conteúdo publicado **decai**: posição cai, informação envelhece, a SERP muda. Toda propriedade tem **cadência de refresh** — revisar o que já existe, não só produzir novo.
- Priorizar por dado do GSC: páginas que **perderam** posição/clique, ou que estão em impressão alta com CTR/posição baixa (perto do top e travadas) — **historical optimization** dá mais retorno que peça nova.
- Refresh de verdade: atualizar dados, cobrir novas perguntas da SERP, melhorar a resposta à intenção, corrigir links internos, atualizar `dateModified` (ver `dados-estruturados.md`). **Não** é trocar a data e republicar (isso é enganação e não engana o buscador).

**SHOULD**
- Ciclo recorrente (ex.: trimestral) de auditoria do mapa (§2) cruzado com GSC pra escolher o lote de refresh e flagrar canibalização (§6).
- Consolidar/aposentar (§5) o que não tem mais razão de existir, em vez de manter zumbi que gasta crawl.

**VETADO**
- Só empilhar conteúdo novo e nunca revisar o antigo — a biblioteca apodrece e canibaliza sozinha.

---

## 8. Distribuição por domínio (não canibalizar entre net/org/me/com.br)

A casa tem **4 domínios**. Todos devem rankear, **nenhum canibaliza o outro** e **nunca há canonical cruzado** entre eles (piso da SKILL; estratégia completa em `internacional-multidominio.md`). A regra é simples: **conteúdo e intenção distintos por domínio**. Cada um é self-canonical; eles se conectam por **links** (os que importam apontam pro `.net`), não por canonical.

| Domínio | Papel | Que conteúdo mora aqui | Intenção dominante |
|---|---|---|---|
| **.net** | Comercial / produto | produto `schematize` (CLI pra esquematizar agentes de IA), consultoria, **cursos**, páginas de conversão | comercial / transacional |
| **.org** | Open-source / pesquisa | docs, pesquisa, especificações, changelog aberto, conteúdo técnico de referência | informacional (técnica) |
| **.me** | Marca / thought-leadership | posições, ensaios, visão, autoridade global, alto E-E-A-T | informacional (marca) / navegacional |
| **.com.br** | Mercado BR | conteúdo **pt-BR** pro mercado local, casos e materiais regionais | informacional/comercial local |

**MUST**
- Antes de escrever, o brief (§4) declara **qual domínio** — e por quê aquele e não outro.
- Um tema tratado em mais de um domínio recebe **ângulos distintos**, não o mesmo texto: ex. "agentes de IA" vira **guia de produto/curso** no `.net`, **spec/docs open-source** no `.org`, **ensaio de visão** no `.me`, **caso do mercado BR em pt-BR** no `.com.br`. Isso é diferenciação (§6), não duplicação (§5).
- **Conversão sempre aterrissa no `.net`**: o CTA de peças em `.org`/`.me`/`.com.br` que levam à compra/curso aponta pro `.net` (link, não canonical).
- pt-BR vs en entre domínios se resolve por **hreflang** quando for a **mesma** intenção em locales diferentes; conteúdo com intenção/ângulo diferente **não** é par de hreflang — é peça distinta (ver `internacional-multidominio.md`).

**SHOULD**
- Manter no mapa (§2) a coluna de domínio preenchida e auditar periodicamente se dois domínios estão convergindo pro mesmo ângulo (risco de canibalização cross-domain).

**VETADO**
- Republicar a mesma peça em dois domínios (§5). Canonical de um domínio da casa pro outro (piso da SKILL). Colocar página de conversão fora do `.net` competindo com o `.net`.

---

## 9. Checklist

Rodar antes de publicar/refazer qualquer conteúdo. Ligar com `checklist-lp.md` (página) e `medicao.md` (baseline).

- [ ] Keyword **primária** definida por pesquisa (seed → expansão), avaliada por volume **e** dificuldade **e** intenção (§1).
- [ ] Long-tail considerada quando a dificuldade do head é alta demais (§1).
- [ ] Linha no **mapa** (§2): keyword primária, secundárias, intenção, URL, **domínio**, status.
- [ ] **Uma** keyword primária por URL e **uma** URL por keyword primária (§2).
- [ ] Peça encaixada num **cluster** com **pillar** — links bidirecionais pillar↔cluster (§3).
- [ ] **Brief** completo: intenção, primária/secundárias, perguntas a responder, entidades, tamanho-alvo por cobertura, links internos, CTA (§4).
- [ ] Conteúdo **responde de fato** à intenção — não é thin nem inchado pra bater contagem (§4, §5).
- [ ] Sem **duplicação** — nem entre páginas do mesmo domínio, nem **entre domínios** da casa (§5, §8).
- [ ] **Canibalização** checada no GSC (quais URLs rankeiam pra query); se houver, resolvida por consolidar / diferenciar / 301 / de-optimize (§6).
- [ ] Nunca **canonical cruzado** entre domínios; tradução tratada por **hreflang recíproco** (§5, §8, `internacional-multidominio.md`).
- [ ] **Domínio** correto pelo papel (net=produto/curso, org=pesquisa/docs, me=marca, com.br=pt-BR) e **CTA de conversão → .net** (§8).
- [ ] Ângulo distinto por domínio quando o tema aparece em mais de um (§8).
- [ ] Página entrou/atualizou na **cadência de refresh**; `dateModified` real quando refresh (§7).
- [ ] **Baseline** registrado (GSC/analytics) pra reavaliar depois (§7, `medicao.md`).
