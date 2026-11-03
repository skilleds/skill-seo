---
name: schematize-seo
metadata:
  version: 0.5.0
description: >-
  SEO estratégico e técnico: crawl, indexação, canonical, hreflang multi-domínio, CWV, keywords, dados estruturados, llms.txt. Use ao planejar/auditar site. Texto: schematize-seo-writing.
---

# Padrões de SEO da Casa (schematize-seo)

Conjunto normativo que rege como a casa **rankeia e é encontrada** — em mecanismos de busca **e** em respostas de IA (AI Overviews, ChatGPT, Perplexity, etc.). É a contraparte de disciplina do `schematize-web`: o **como implementar** no frontend (RSC, build, Core Web Vitals na prática, a11y, deploy) **delega ao schematize-web**; o **o quê, por quê e com qual estratégia** de SEO — técnico, conteúdo, keywords, dados estruturados, multi-domínio, autoridade, medição — é governado aqui.

**Versão:** skill `schematize-seo` v0.5.0. Changelog em `CHANGELOG.md`.

## Precedência e herança (leia antes de divergir)

<!-- herdado:engineering/precedencia:dominio intro="Esta skill é o recorte **SEO estratégico e técnico** da base: governa o que e por quê; o como no frontend é da `schematize-web`." cmd="seo" -->Esta skill é o recorte **SEO estratégico e técnico** da base: governa o que e por quê; o como no frontend é da `schematize-web`.

1. **Onde esta skill divergir da base, a BASE MANDA.** Aqui mora a especialização do domínio ou da
   ferramenta — o como, o padrão, o gate. Divergência de *piso* é defeito desta skill, não variante local.
2. **O que não está repetido aqui é HERDADO, não dispensado.** Esta skill herda os pisos da base e
   os comandos dela cobrem o **domínio**, não o piso geral. Valem integralmente, sem cópia local:
   - **§28 Archive** — `<projeto>/<projeto>_archive/` é **repositório git próprio, PRIVADO e
     obrigatório**, criticidade 0 (`schematize-archive`).
   - **§35 Definition of Done** e a lista de anti-padrões (citada por **título**, nunca por número).
   - **§39 Índice/MAPA** — enumeração exaustiva (uma entrada por unidade chamável, `M == N`) e grafo
     com arestas em ASCII (`A -> B`), nunca a seta unicode.
   - **IAM** (`schematize-engineering` → `references/iam.md`): identidade ≠ email, ≥2 fatores, ReBAC
     multi-tenant, argon2id-only para senha nova, sessão longa e logout irreversível.
   - **Efeito externo** nunca sai de não-produção (`schematize-engineering` →
     `references/efeitos-externos.md`).
   - **Orquestração** (`schematize-engineering` → `references/orquestracao.md` §9): o principal não
     desenvolve (é Claude Opus); executor mais barato que resolve — `haiku`/`sonnet` → Codex Terra → Cursor → `opus` só após falha; visual direto ao Codex; imagem nunca pelo Claude: detecta Codex/Gemini e pergunta ao usuário qual usar (Codex é a sugestão, não automática), nunca API paga.
3. **QA, ops, IAM e índice não têm comando próprio aqui:** vêm da base `/eng-*`. Para trabalho
   contínuo use `/eng-overdev`; para planejar `/eng-plan`; para varrer a base `/eng-scan`; para
   revisão geral `/eng-review` (e `/eng-ops`, `/eng-iam`, `/eng-index`). Os comandos
   `/seo-*` cobrem o domínio desta skill; o piso geral é o da base.<!-- /herdado -->

## Comandos (Claude Code)

Digite `/seo-help` pra ver todos. Em resumo:

| Comando | O que faz |
|---|---|
| `/seo-help` | lista todos os comandos do schematize-seo |
| `/seo-audit` | auditoria SEO de um site/página: técnico, on-page, dados estruturados, CWV, internacional, AIO — plano → aprovação → relatório priorizado |
| `/seo-plan` | plano de SEO de uma propriedade: mapa de intenção, topic clusters, arquitetura de URL, estratégia multi-domínio (net/org/me/com.br), KPIs |
| `/seo-keywords` | pesquisa e mapa de keywords por intenção + agrupamento em clusters, com anti-canibalização (uma intenção por URL) |
| `/seo-review` | revisa uma página/PR pelo gate de SEO (title/meta/H1/URL/canonical/hreflang/schema/alt/internal links) e reprova o que quebra piso |
| `/seo-load` | carrega à força TODO o corpo normativo de SEO no contexto e passa a aplicá-lo como regra inegociável |
| `/seo-claude` | cria ou ATUALIZA o `CLAUDE.md` da raiz com o bloco sempre-on de SEO (mescla, com backup) |
| `/seo-cc` | context compact: grava o handoff **com o baseline medido** no archive e roda `/compact` |
| `/seo-handoff` | gera o handoff **sem** compactar — pra fim de sessão |

Os comandos ficam em `assets/commands/` e são instalados em `.claude/commands/`.

## Como usar esta skill

1. Identifique o domínio da tarefa e **leia o(s) reference(s) relevante(s)** antes de produzir plano, conteúdo, markup ou código. Não trabalhe de memória — táticas e thresholds mudam e estão nos arquivos.
2. **Sempre** aplique os pisos inegociáveis abaixo, independente do reference carregado.
3. Se a tarefa exigir implementação no frontend (rotas, RSC, `metadata`, sitemap autogerado, performance real, a11y), **carregue também o schematize-web** — esta skill diz *o que* e *por quê*; o web diz *como codar*.
4. Rode o gate sobre o build (`scripts/check-seo.sh`, abaixo) e, ao terminar, valide contra o `references/checklist-lp.md` (por página) e **registre o baseline no
   archive do projeto** (`<projeto>_archive/scan/AAAA-MM-DD-seo-baseline.md`), seguindo o método de
   `references/medicao.md`. *A skill é normativa e versionada: gravar medição dentro dela faria o
   modelo **editar a própria reference** a cada auditoria — e a normativa da casa viraria o caderno
   de um projeto.*

Mapa de references — leia o que casa com a tarefa:

| Tarefa | Reference |
|---|---|
| Como busca e resposta-de-IA rankeiam hoje, intenção, E-E-A-T, o funil crawl→index→rank→cita→converte, filosofia | `references/fundamentos.md` |
| SEO técnico: crawlability/indexação, robots.txt, sitemaps, canonical, status/redirects, arquitetura de site, internal linking, Core Web Vitals para SEO, mobile-first, HTTPS, JS/render SEO | `references/tecnico.md` (índice) → `crawl-index.md`, `cwv.md`, `arquitetura.md`, `sitemaps.md`, `checklist-tecnico.md` |
| On-page: title, meta description, headings (um H1/uma intenção), desenho de URL, HTML semântico, mídia/alt, âncoras internas, snippets | `references/on-page.md` |
| Pesquisa de keywords, mapa por intenção, topic clusters + pillar pages, briefs de conteúdo, anti-thin/duplicado, cadência de refresh, canibalização. **Escrever o texto** (outline, briefings por seção, parágrafos): `schematize-seo-writing` | `references/keywords-conteudo.md` |
| Dados estruturados: catálogo schema.org (Organization, WebSite, SoftwareApplication, Product, Course, Article, BreadcrumbList, FAQ…), JSON-LD, rich results, validação | `references/dados-estruturados.md` |
| **Internacional e MULTI-DOMÍNIO sem canibalizar:** ccTLD vs gTLD, hreflang recíproco, self-canonical por propriedade, conteúdo distinto por domínio, split comercial/institucional/marca, estratégia de redirect dos "links que importam" pro domínio-âncora | `references/internacional-multidominio.md` |
| **Descoberta por IA: AIO/LLMO/GEO**, AI Overviews e answer engines, conteúdo extraível/citável, `llms.txt`, entidade/knowledge graph, E-E-A-T para IA | `references/aio-llmo-geo.md` |
| Autoridade e off-page: backlinks de qualidade, digital PR, sinais de marca/entidade, autoria/E-E-A-T, higiene de link tóxico | `references/autoridade-eeat.md` |
| Medição: Google Search Console, analytics, rank tracking, análise de log, KPIs por etapa do funil, experimentos, relatório | `references/medicao.md` |
| Filosofia e a lista completa de anti-padrões (black-hat + erros comuns: canibalização, over-canonical, thin, keyword stuffing, hreflang quebrado…) | `references/anti-padroes.md` |
| **Checklist de SEO por página/LP** (pré-publicação) — a ponte pro trabalho de landing page | `references/checklist-lp.md` |

## Pisos inegociáveis (vetam o atalho)

Independente do reference, estes limites nunca são cruzados:

1. **Zero black-hat.** Nada de cloaking, doorway pages, texto oculto, keyword stuffing, PBN, link comprado dissimulado, conteúdo gerado em massa sem valor. Queima o domínio — e domínio com autoridade (como `.me`/`.com.br` da casa) é ativo caro de reconstruir.
2. **Uma intenção por URL.** Toda página indexável responde a **uma** intenção de busca dominante. Duas páginas disputando a mesma intenção/keyword = **canibalização**: consolida, diferencia ou 301. Ver `keywords-conteudo.md` e `anti-padroes.md`.
3. **Self-canonical por padrão.** Toda página indexável aponta `rel=canonical` pra si mesma (URL absoluta, uma versão: https, com/sem www decidido, sem parâmetros de tracking na canônica).
4. **Nunca canonical cruzado entre os domínios distintos da casa.** `.net`, `.org`, `.me` e `.com.br` são propriedades com **conteúdo e intenção distintos** — cada uma é self-canonical. Canonicalizar `.me`→`.net` jogaria fora a autoridade do `.me`. Elas se diferenciam por conteúdo e se conectam por links (os "que importam" apontam pro `.net`), **não** por canonical. Ver `internacional-multidominio.md`.
5. **hreflang só para tradução 1:1 do MESMO conteúdo** (idioma/região), nunca entre conteúdos distintos dos domínios da casa (esses ligam por link):  todo conjunto inclui `x-default`, cada URL lista todas as alternativas (inclusive a si), e os apontamentos são recíprocos. hreflang quebrado é ignorado pelo Google.
6. **Indexabilidade intencional.** O que deve rankear é rastreável e indexável (não bloqueado por robots, sem `noindex` acidental, sem depender de JS que o crawler não executa); o que não deve (staging, filtros infinitos, carrinho) é `noindex`/bloqueado de propósito.
7. **Title, meta e H1 únicos e verdadeiros por página.** Nada de title duplicado no site, nada de meta genérica, nada de H1 que promete o que a página não entrega (o *pogo-stick* do usuário derruba o rank).
8. **Dados estruturados válidos e verdadeiros.** JSON-LD que reflete o conteúdo visível na página; passa no validador; sem marcar rich result que a página não mostra (é violação e vira penalização manual).
9. **Performance e a11y contam como SEO.** Core Web Vitals no verde e acessibilidade AA não são "extra" — são fator de rank e de extração por IA. A implementação delega ao `schematize-web`, mas o SEO **exige** o resultado.
10. **Medir antes e depois.** Toda mudança relevante de SEO tem baseline (GSC/analytics) e é reavaliada. Sem medição, é achismo — e achismo em SEO custa meses.
11. <!-- herdado:engineering/orquestracao:curto -->**Orquestrador não desenvolve; subagent barato executa.** O agent principal só planeja, despacha e revisa; ação onerosa vira micro-tasks para o executor mais barato que resolve: `haiku` (mecânico) / `sonnet` (código; falhou → mesmo subagent corrige, até 2 rodadas) → Codex `gpt-5.6-terra` → Cursor → subagent `opus` (motivo) → `park`; **visual vai direto ao Codex**; **imagem nunca pelo Claude: detectar Codex/Gemini e perguntar ao usuário qual usar (Codex é a sugestão), nunca API de imagem paga**; papéis em `agentes.toml`. No overdev, cada item do checklist vai a um subagent e o principal revisa antes do `- [x]`. **Sem frota ociosa:** idle com pendência volta ao trabalho; dependente de outro agent → mata e enfileira com gatilho; terminou → mata (§9.6). Detalhe: `schematize-engineering` → `references/orquestracao.md` §9.<!-- /herdado -->

## Gate executável (máquina)

`bash scripts/check-seo.sh <dir-do-build>` roda sobre o HTML publicado e reprova (exit 1): canonical ausente/relativa/com parâmetro/**cruzando domínio**, hreflang sem `x-default`/self/recíproco **ou entre conteúdos distintos** (`hreflang-conteudo-distinto`; tradução entre hosts exige `<!-- seo-variant: slug -->` igual nas duas), `--host` obrigatório com canonicals em >1 host, `seo-ok:` sem motivo, sitemap sem `<loc>`, `title`/`description` ausentes ou **duplicados**, `h1` ausente, `robots.txt` que bloqueia tudo ou sem `Sitemap:`, sitemap ausente. Rode no `tools/ci.sh` local e na promoção a hml (piso 27, sem CI por commit/PR). Exit 2 = sem HTML (nada verificado, não é aprovação). `scripts/check-seo.test.sh` é o vermelho do próprio gate. O que a máquina não lê (intenção, canibalização, veracidade do título) segue no `/seo-review`.

## Relação com as outras skills

- **schematize-web** — implementação de frontend: `metadata`/tags no App Router, sitemap/robots autogerados, i18n com URL por idioma, Core Web Vitals na prática, a11y, deploy. Esta skill define a estratégia; o web executa. Há sobreposição proposital em `seo-i18n.md`/`aio-llmo-geo.md` do web — aqui é a fonte canônica da **disciplina**; lá, do **código**.
- **schematize-engineering** — quando o SEO exige backend (renderização server-side de conteúdo, geração de sitemaps em escala, i18n de dados), delega o back ao `engineering`/`go`.

- **schematize-seo-writing** — a **redação** do texto (outline H1/H2/H3, briefings por seção, parágrafos curtos com BLUF, checador executável; `/seow-write`, `/seow-outline`, `/seow-revise`). A fronteira: esta skill decide estratégia, intenção, keywords (`/seo-keywords`), dados estruturados (FAQ é Q&A visível, sem `FAQPage`), multi-domínio e AIO; a `schematize-seo-writing` **escreve** o texto de uma URL cuja intenção e keywords já saíram daqui.
- **schematize-analytics** — o **comportamento depois do clique**: funil, conversão, evento como contrato (tracking plan), consentimento LGPD sem PII e A/B. Esta skill mede a **chegada** (GSC, rank, indexação, CWV de campo); o que o usuário faz depois de chegar é `schematize-analytics → references/metricas.md` e `schematize-analytics → references/plano-de-tracking.md`.
- **schematize-institutional** — o **inventário de páginas** de um site de empresa (quais páginas
  existem, o que cada uma prova, e as **páginas legais** obrigatórias). A fronteira: a
  `schematize-institutional` diz **quais páginas existem e o que dizem**; esta skill diz **como
  elas rankeiam e são citadas** (intenção, cluster, canibalização, hreflang, dados estruturados);
  a `schematize-web` diz **como são construídas**. Sitemap e robots seguem o piso desta skill —
  **autogerados**, nunca à mão: sitemap escrito à mão envelhece na primeira página nova e passa a
  **mentir para o crawler**, o que é pior que não ter. *(A `schematize-institutional` entregava um
  `sitemap.xml` à mão, que esta skill e a `schematize-web` vetam — achado da Classe F da vistoria
  de 2026-08-21.)*


**Herda os pisos 22–29** da `schematize-engineering` (git como trava de conclusão, deploy só do git, ops é o gate da IA, sem agents inúteis, relatório 30 min/handoff 6 h, CI remoto só antes do hml, microserviço autônomo, build em dev/hml + higiene).

<!-- herdado:engineering/pisos-22-29:bloco -->**Herda os pisos 22–29 da `schematize-engineering`** (texto completo em `assets/CLAUDE.md` dela): 22 tudo no git — sem remote, push falho ou HEAD≠origin a demanda NÃO se conclui; 23 deploy só do git (VETADO scp/rsync/tar|ssh/docker save|load/git bundle); 24 o ops é o gate da IA — a IA nunca muda a VPS direto nem escreve SQL, só operação nomeada (`ssh vps "ops <op>"`); 25 sem agents inúteis (entregou, morreu); 26 relatório a cada 30 min e handoff a cada 6 h; 27 CI remoto só antes do hml, a pedido ou em tag (`workflow_dispatch` + `hml-*`/`v*`; VETADO `pull_request`, `push` em branch, `workflow_run`, cron sem justificativa); 28 microserviço autônomo (fila durável + 7 testes de resiliência); 29 build/teste na máquina dev/hml quando existe (ponte só no workspace de build, nunca prd) + higiene (`scripts/higiene.sh`).<!-- /herdado -->
