# Changelog — schematize-seo

Todas as mudanças relevantes deste pacote, no formato [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/),
com versionamento [SemVer](https://semver.org/lang/pt-BR/).


## [Não lançado]
### Corrigido
- P0: `assets/CLAUDE.md` mandava hreflang recíproco entre domínios de conteúdo distinto; agora hreflang só em tradução 1:1 do mesmo conteúdo, conteúdo distinto liga por link; removido "irreversível". SKILL.md e `/seo-load` alinhados.
- `check-seo.sh`: regra `hreflang-conteudo-distinto` (host diferente exige `seo-variant` igual), `host-ambiguo` (sem inferir host pela maioria; `--host a,b`), `waiver-sem-motivo` + aviso dos waivers, `rel=canonical` sem aspas, `sitemap-sem-loc`. Testes 15 → 24.
- `dados-estruturados.md`: Organization no `.net`; sem `SearchAction`/`FAQPage` em exemplo e checklist. `fundamentos.md` sem `FAQPage`.
- `/seo-load` carrega `autoridade-eeat.md`; `/seo-audit` chama `check-seo.sh` e não usa `/tmp`; `crawl-index.md` §2.3 renumerada.
- Herda os pisos 22–29 da engineering (bloco curto).

## [0.5.0] — 2026-10-14
O piso de SEO ganha gate de máquina e a fronteira com `schematize-analytics`.

### Corrigido

- `check-seo.sh` sai com o status real (sem `exit 0` incondicional no fim).

### Alterado
- Novo `scripts/check-seo.sh` + `check-seo.test.sh` (15 casos, vermelhos e verdes): sobre o HTML publicado reprova canonical ausente/relativa/com parâmetro/cruzando domínio, hreflang sem `x-default`/self/recíproco, `title`/`description` duplicados ou ausentes, `h1` ausente, `robots.txt` que bloqueia tudo ou sem `Sitemap:`, sitemap ausente (exit 2 se não há HTML). Motivo: os pisos só existiam como prosa e a skill nem tinha `scripts/`.
- Ponteiro "comportamento depois do clique" para `schematize-analytics` (`SKILL.md`, `assets/CLAUDE.md`, `references/medicao.md`); `/seo-review` roda o gate antes da leitura humana.
- Blocos herdados `engineering/precedencia` (variante `dominio`) e `engineering/orquestracao` inseridos onde faltavam e sincronizados (`tools/sync-herdados.mjs`).
- Description reduzida para ≤190 caracteres (orçamento do catálogo, 45 skills).

## [0.4.1] — 2026-10-14
### Adicionado
- Ponteiros para a nova `schematize-seo-writing` (redação do texto) em `SKILL.md` (mapa de references e relação com as outras skills) e em `references/keywords-conteudo.md` §4: a estratégia, o brief por peça e as keywords continuam aqui; escrever o texto, com briefing por seção e checador, é da skill nova. Sem bump de versão por ora.

### Alterado
- Description reduzida (≤235 chars) para caber no orçamento de listagem de skills (soma ≤8300); mesmo território, fronteiras com as irmãs preservadas.

## [0.4.0] — 2026-10-14
### Corrigido
- **Data do FAQ rich result incoerente** ("anunciada em 08/05, deixou de aparecer em 07/05") em `stack-versoes.md` e `dados-estruturados.md`: reverificado por busca (fontes secundárias): aviso de depreciação e fim da exibição em 07/05/2026; data exata do anúncio marcada `<!-- reverificar -->`.
- `description` do frontmatter reduzida a ≤350 caracteres em bloco `>-`.

### Alterado
- **`tecnico.md` (393 linhas) dividido por coesão:** `crawl-index.md` (§1–6), `cwv.md` (§7–8), `arquitetura.md` (§9), `sitemaps.md` (§10–11) e `checklist-tecnico.md`; `tecnico.md` virou índice curto (outras skills o citam). Numeração § preservada; referências internas atualizadas. O porquê: um arquivo único de 393 linhas misturava cinco assuntos e obrigava a carregar tudo.
- `cwv.md` aponta `schematize-web → references/stack-versoes.md` para limiares, INP e janela de 28 dias (fonte única).
- **Description** reduzida (~270 chars) para caber no orçamento de listagem (soma das 31 skills ≤ 8500; o Claude Code corta a listagem acima disso).

## [0.3.0] — 2026-08-21
Segunda leva do saneamento: as lacunas de escopo e as contradições em MUST do inventário da vistoria.

### Adicionado
- **`tecnico.md` §2.1 — controlar o SNIPPET:** `nosnippet`, `max-snippet` (com `0` = nosnippet e **`-1`** = sem limite), **`data-nosnippet`** (que exclui **um pedaço** e é o que serve para conteúdo pago sem apagar a página da SERP), `max-image-preview:large`, `max-video-preview`, `noarchive` — *os únicos controles que afetam diretamente o que buscador e answer engine mostram*. Com as duas armadilhas: **`nosnippet` é faca de dois gumes** (sem trecho, o CTR cai e você some da resposta de IA) e o VETADO de usar `robots.txt` para "tirar do Google" (bloqueado = `noindex` **nunca lido**).
- **`tecnico.md` §9.1 — paginação e navegação facetada:** `rel=next/prev` aposentado, **self-canonical por página** (canonicalizar tudo para a página 1 faz o item da página 7 sumir), e a faceta tratada com `noindex,follow` **sem** link navegável — nunca só `Disallow`. Mais o sintoma de vazamento de crawl budget.
- **`tecnico.md` §11 — além do Google:** RFC 9309, **IndexNow** (*push* de mudança, não inventário; não é canal do Google), **Indexing API** só para `JobPosting`/vídeo ao vivo, **sitemap de imagem e vídeo**, e o **limite de 16 meses do GSC** — com a consequência: exporte mensalmente, porque descobrir isso no dia em que você precisa do dado de 18 meses atrás é tarde demais.

### Corrigido
- **Duas contradições em MUST.** (1) A **âncora da entidade** era `.org` no `dados-estruturados.md` e `.net` no `internacional-multidominio.md`: a fonte única passou a ser o reference central de domínios (`.net` no `@id`/`url`, os outros em `sameAs`), com o motivo escrito — *duas âncoras fazem o buscador ver **duas organizações** com o mesmo nome, e a autoridade que deveria somar se divide*. (2) O **idioma do `.net`**: a tabela define en, e os exemplos marcavam `inLanguage: "pt-BR"` em URL `.net`; corrigidos (o exemplo pt-BR foi para o `.com.br`), porque **markup errado é copiado com muito mais facilidade do que prosa certa**.
- **`llms.txt` virou SHOULD** (era MUST com gate de publicação): ✔ verificado — é proposta que **nenhum crawler grande adotou**, e travar release por um arquivo que ninguém consome **ensina o time a desligar gate**. A `schematize-web` já dizia SHOULD; agora as duas concordam.
- **`operatingSystem` deixou de ser a constante `"Linux"`** e passou a espelhar a **matriz de release** (✔ o updater da casa publica para Linux, macOS e Windows). Declarar menos SOs tira você do resultado; declarar mais é markup falso.
- **`§N` com dois sentidos** no checklist do `anti-padroes.md`: as remissões a **itens da tabela** viraram "item N" (a regra `item-por-numero` do lint existe por essa classe).
- **Baseline de medição** deixou de ser gravado dentro da reference: vai para o **archive do projeto**. *Gravar medição na skill faria o modelo editar a própria normativa a cada auditoria.*
- Thresholds de title/meta e Core Web Vitals com **fonte única**; `|` escapado na tabela de `on-page.md`; fence órfã removida em `dados-estruturados.md`; remissões de dados estruturados apontando `dados-estruturados.md` (o `tecnico.md` não trata de schema).

## [0.2.0] — 2026-08-21
Saneamento do catálogo conforme a vistoria de 2026-08-21.

### Corrigido
- **Core Web Vitals: uma fonte só.** Os números saíram do corpo (inclusive a última duplicata no checklist do `tecnico.md`) e ficaram **apenas** no anexo volátil da `schematize-web`, que tem `Verificado em:`. O corpo mantém o que não envelhece: o que cada métrica mede e a exigência de **verde em campo (CrUX/GSC, p75)**.
- **Thresholds de title/meta em um valor só:** `on-page.md` é a fonte (~50–60 chars / ≤ ~600px; ~150–160), e o `checklist-lp.md` **remete** em vez de repetir — com o que faz o número ser aproximado: **o corte na SERP é por pixel, não por caractere**.
- **Dados estruturados** deixaram de ser buscados no `tecnico.md` (que não tem uma linha sobre schema): as 4 remissões de `fundamentos.md` apontam `dados-estruturados.md`.
- **Tabela quebrada e fence órfã:** `|` dentro de código inline escapado em `on-page.md` (era justamente nos exemplos de título com sufixo de marca) e a ``` sobrando no fim de `dados-estruturados.md`, que fazia o checklist inteiro renderizar como código.

### Adicionado
- `assets/CLAUDE.md` e os comandos `/seo-load`, `/seo-cc`, `/seo-handoff`, `/seo-claude`; o `/seo-audit` ganhou os passos concretos de coleta (`curl`/`grep`) e a regra **"sem resposta HTTP, não há veredito"**.

## [0.1.0] — 2026-08-10

Primeira versão da skill de SEO da casa.

### Adicionado
- **SKILL.md** com 10 pisos inegociáveis (zero black-hat, uma intenção por URL,
  self-canonical, **nunca canonical cruzado entre os domínios da casa**, hreflang
  recíproco, indexabilidade intencional, title/meta/H1 únicos, dados estruturados
  válidos, performance/a11y como SEO, medir antes/depois).
- **references/**:
  - `fundamentos.md` — como busca e resposta-de-IA rankeiam, intenção, E-E-A-T, funil.
  - `tecnico.md` — crawl/index/render, robots, sitemaps, canonical, redirects,
    arquitetura, internal linking, Core Web Vitals para SEO, mobile-first, JS SEO.
  - `on-page.md` — title/meta/headings/URL/semântica/mídia/âncoras.
  - `keywords-conteudo.md` — pesquisa, intenção, topic clusters/pillar, briefs,
    anti-thin, canibalização, refresh.
  - `dados-estruturados.md` — schema.org/JSON-LD, rich results, validação.
  - `internacional-multidominio.md` — ccTLD/gTLD, hreflang, self-canonical por
    propriedade, conteúdo distinto por domínio, estratégia de redirect (net/org/me/com.br).
  - `aio-llmo-geo.md` — AI Overviews/answer engines, GEO, llms.txt, citabilidade, entidade.
  - `autoridade-eeat.md` — backlinks/digital PR, sinais de marca, autoria, link tóxico.
  - `medicao.md` — GSC, analytics, rank, log, KPIs, experimentos, relatório.
  - `anti-padroes.md` — black-hat + erros comuns.
  - `checklist-lp.md` — checklist de SEO por página/LP (pré-publicação).
- **assets/commands/**: `/seo-help`, `/seo-audit`, `/seo-plan`, `/seo-keywords`, `/seo-review`.
