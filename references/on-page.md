# On-Page: title, meta, headings, URL, semântica, conteúdo, mídia, snippets

> Parte da skill **schematize-seo**. Governa o que fica **dentro da página** — os sinais que dizem ao buscador e à IA sobre o que ela é e por que merece rankear. Estratégia de keywords e intenção fica em `keywords-conteudo.md`; crawl/index/canonical/redirect em `tecnico.md`; JSON-LD em `dados-estruturados.md`; multi-domínio e hreflang em `internacional-multidominio.md`; extração/citação por IA em `aio-llmo-geo.md`. O checklist final por página vive em `checklist-lp.md` — este arquivo é a fonte da disciplina que ele cobra.

## Como ler

- **MUST** — regra. Desvio bloqueia publicação ou exige ADR.
- **SHOULD** — padrão. Desvio precisa de justificativa no PR.
- **VETADO** — piso. Não tem ADR de exceção. Aparece no diff → para.

**Contexto da casa (vale para tudo aqui):** quatro domínios — `.net` (comercial/produto: o CLI `schematize`, consultoria, cursos), `.org` (open-source/pesquisa), `.me` (marca/global, alta autoridade) e `.com.br` (BR/pt-BR). Cada um é **self-canonical**, com **conteúdo e intenção distintos**, e **nunca** canonicaliza pro outro. A conversão sempre aponta pro `.net`. On-page é o principal instrumento para **rankear os quatro sem canibalizar**: se duas páginas (no mesmo domínio ou entre domínios) disputam a mesma intenção com o mesmo title/H1/conteúdo, você não tem quatro ativos — tem um diluído em quatro. Diferencie no on-page ou consolide (ver `anti-padroes.md`).

---

## 1. Title tag

O title é o sinal on-page mais forte e o principal gatilho de clique na SERP e em cartões de IA.

**MUST**
- **Um title único por página** em todo o site. Title duplicado é canibalização anunciada.
- **Keyword primária no começo**, o mais à esquerda que a leitura natural permitir. O peso e a truncagem penalizam o que fica no fim.
- **Marca no fim**, separada por `|` ou `:` (o checador de seo-writing reprova travessão) (ex.: `… | Schematize`). Homepage pode abrir pela marca.
- Descrever **a intenção real da página**. Title que promete o que o corpo não entrega gera *pogo-stick* (usuário volta pra SERP) e derruba o rank.
- Escrito no idioma do conteúdo (`.com.br` em pt-BR; `.me`/`.net`/`.org` conforme o locale da página — ver `internacional-multidominio.md`).

**SHOULD**
- Diferenciar o title por domínio para o mesmo tema, refletindo o ângulo de cada propriedade (comercial vs. pesquisa vs. marca vs. BR). Mesmo tema, títulos distintos → quatro páginas rankeando, não quatro brigando.

**Thresholds**

| Item | Regra |
|---|---|
| Comprimento | **~50–60 caracteres**, alvo **≤ ~600px** (o Google trunca por **pixel**, não por caractere — um título de 55 chars em maiúsculas ou com muitos "M"/"W" trunca antes de um de 60 em minúsculas). **Esta é a fonte única do número no catálogo**; `checklist-lp.md` remete para cá |
| Posição da keyword | Primária nos primeiros ~30 caracteres |
| Marca | Sufixo `\| Marca`, ~10–13 chars reservados (o `\|` vai escapado: numa tabela Markdown, `|` dentro de código inline **quebra a linha em colunas**) |
| Unicidade | 100% únicos no site (zero duplicado) |
| Stuffing | No máximo **uma** repetição da keyword; nada de listar variações |

**Bom vs. ruim**

| | Exemplo |
|---|---|
| Ruim | `Home - Bem-vindo ao nosso site!` |
| Ruim | `Schematize - CLI, agentes, IA, consultoria, cursos, esquematizar` (stuffing) |
| Bom (.net) | `Esquematize agentes de IA com o CLI Schematize \| Schematize` |
| Bom (.org) | `Como esquematizamos agentes: método aberto \| Schematize.org` |

---

## 2. Meta description

Não é fator de rank **direto**, mas move **CTR** — e CTR é sinal. É o texto do anúncio orgânico.

**MUST**
- **Uma description própria por página** — nunca herdar uma genérica do layout, nunca deixar o buscador escolher um trecho aleatório.
- Conter a **keyword primária** (aparece em negrito na SERP quando casa com a query) e um **CTA** concreto.
- Refletir a página. Description que engana infla CTR e depois pune com bounce.

**Thresholds**

| Item | Regra |
|---|---|
| Comprimento | **~150–160 caracteres** (trunca ~920px no desktop, menos no mobile) |
| Keyword | Primária presente, cedo |
| CTA | Verbo de ação (`Comece`, `Baixe`, `Veja como`) |
| Unicidade | Única por página |

**Bom vs. ruim**

| | Exemplo |
|---|---|
| Ruim | `Somos uma empresa comprometida com a excelência e a inovação.` |
| Bom | `Esquematize seus agentes de IA em minutos com o CLI Schematize. Instale, versione skills e padronize sua stack. Comece grátis.` |

---

## 3. Headings (H1–H3)

Headings são o esqueleto semântico: dizem a busca e à IA a estrutura do argumento.

**MUST**
- **Exatamente UM `<h1>` por página**, e ele expressa **a intenção da página** (não a marca, não o menu). Casa com o title, sem ser cópia literal.
- **Hierarquia sem pular nível**: `h1 → h2 → h3`, nunca `h1 → h3`. A ordem no DOM é a ordem lógica (a mesma que serve a a11y — ver `schematize-web`).
- Headings **descritivos**, não decorativos: quem lê só os headings entende a página. Isso é o que alimenta o índice de featured snippets e o parsing por IA.

**SHOULD**
- Colocar variações semânticas e entidades nos `h2`/`h3` (não repetir a keyword primária em todos).
- Formular `h2`/`h3` como **as perguntas do People Also Ask** quando fizer sentido — vira alvo direto de snippet.

**VETADO**
- Mais de um `h1`. Usar heading pra tamanho de fonte em vez de estrutura. Heading vazio ou só com ícone/imagem sem texto.

---

## 4. Desenho de URL

A URL é sinal de rank e de confiança do clique. Estável e legível.

**MUST**
- **Curta, minúscula, com hífen** separando palavras (`-`, nunca `_` nem espaço/`%20`).
- **Keyword na URL**, refletindo a intenção. Sem palavra de enchimento (`/pagina-sobre-o-nosso-produto-de-ia`).
- **Sem parâmetros nem IDs** quando evitável (`?id=8231`, `?ref=`, `;jsessionid`). Tracking não entra na URL canônica.
- **Estável.** URL publicada não muda por capricho; se mudar, **301** obrigatório (ver `tecnico.md`). URL é um ativo — trocar zera o link equity.
- Profundidade rasa: preferir ≤ 3 segmentos.

**Thresholds**

| Item | Regra |
|---|---|
| Caso | tudo minúsculo |
| Separador | hífen `-` |
| Slug | ~3–5 palavras, sem stop words desnecessárias |
| Parâmetros | zero na canônica; filtros/tracking com canonical/`noindex` coerente |
| Estabilidade | mudou → 301 |

**Bom vs. ruim**

| | Exemplo |
|---|---|
| Ruim | `.net/p?id=8231&cat=cli&utm_source=x` |
| Ruim | `.net/Produtos/O_Nosso_CLI_Para_Esquematizar_Agentes` |
| Bom | `.net/cli-agentes-ia` |
| Bom | `.org/pesquisa/metodo-esquematizacao` |

---

## 5. HTML semântico

Estrutura semântica ajuda buscador e IA a separar conteúdo de cromo, e é a mesma que serve a a11y.

**MUST**
- Usar os elementos certos: **`<main>`** (um por página, o conteúdo único), **`<article>`** (conteúdo autônomo: post, ficha), **`<section>`** (bloco temático com heading), **`<nav>`** (navegação), `<header>`/`<footer>`. Nada de `div` genérica onde há elemento semântico.
- **Conteúdo principal renderizado no servidor** (SSR/SSG) — o crawler e o extrator de IA precisam ver o conteúdo sem depender de JS que talvez não executem (ver `tecnico.md` e `schematize-web`).
- Um `<article>` por peça de conteúdo indexável, com o `<h1>` dentro.

**SHOULD**
- Marcar breadcrumb visual com `<nav aria-label>` + `BreadcrumbList` no JSON-LD (`dados-estruturados.md`).

---

## 6. Conteúdo on-page

**MUST**
- **Responder à intenção acima da dobra.** A primeira tela entrega a resposta principal — não obriga a rolar pra descobrir do que a página trata. É o que a busca mede (dwell) e a IA extrai.
- **Keyword primária + variações semânticas e entidades** relacionadas, distribuídas com naturalidade. Cobrir o campo semântico do tópico, não repetir a mesma string.
- **Profundidade adequada à intenção** — completo o bastante pra encerrar a busca, sem encher. A régua é a intenção, não uma contagem de palavras.
- **Um ângulo distinto por domínio.** `.net` = produto/conversão; `.org` = método/pesquisa aberta; `.me` = visão/marca; `.com.br` = mercado/contexto BR. Mesmo tema, quatro páginas com conteúdo genuinamente diferente → rankeiam juntas. Copiar entre domínios é canibalização e conteúdo duplicado (`internacional-multidominio.md`, `anti-padroes.md`).

**VETADO**
- **Thin content** — página sem substância própria, doorway, ou variação rasa de outra só pra ocupar keyword.
- **Keyword stuffing** — repetir a keyword contra a leitura natural.
- Copiar o corpo de um domínio da casa pra outro (ou traduzir e servir igual sem adaptar).

---

## 7. Mídia

**MUST**
- **`alt` descritivo** em toda imagem informativa (o que ela mostra e por que importa; `alt=""` se for puramente decorativa). Serve a11y, image search e IA.
- **Nome de arquivo descritivo** com hífen (`cli-schematize-terminal.png`, não `IMG_2831.png`).
- **`width`/`height` (ou `aspect-ratio`)** declarados pra evitar CLS.
- **`lazy` sem quebrar o LCP**: a imagem do LCP (herói) é `eager`/`fetchpriority=high`; o resto é `loading="lazy"`. Lazy no recurso de LCP é regressão de Core Web Vitals — e CWV conta como SEO (ver `schematize-web`).

**SHOULD**
- Formato moderno (AVIF/WebP), `srcset` responsivo, imagem citável para IA quando aplicável.

---

## 8. Âncoras internas (internal links)

Links internos distribuem autoridade e ensinam a busca sobre o tópico da página de destino.

**MUST**
- **Texto de âncora descritivo**, contendo a keyword/tema do destino. **VETADO** `clique aqui`, `saiba mais`, `este link` como âncora.
- Apontar para a página **canônica** do destino (não pra uma variação com parâmetro).
- Ligar cada peça ao seu **cluster** — pillar ↔ artigos de apoio (topic clusters em `keywords-conteudo.md`).

**SHOULD**
- Do conteúdo institucional/pesquisa (`.me`/`.org`/`.com.br`) para o `.net`, o link de conversão usa âncora comercial clara. São os "links que importam" que consolidam o `.net` como âncora comercial **sem** canonical cruzado (`internacional-multidominio.md`).

---

## 9. Featured snippet e People Also Ask

Otimização para posição zero e para caixas de resposta — as mesmas estruturas que a IA extrai e cita.

**MUST (quando a intenção for informacional)**
- **Parágrafo-resposta** logo após o heading da pergunta: 40–60 palavras que respondem de forma completa e autônoma. É o formato que o snippet de parágrafo captura.
- **Listas** (`<ol>`/`<ul>`) para processos e enumerações — alvo do snippet de lista.
- **Tabelas** (`<table>` real, não imagem) para comparações e dados — alvo do snippet de tabela.
- Formular headings como **as perguntas reais** (colhidas do PAA e do `keywords-conteudo.md`) e respondê-las imediatamente abaixo.

**SHOULD**
- Bloco de FAQ quando houver perguntas legítimas — **sem** `FAQPage` JSON-LD: o rich result está morto (✔ 2026-08-21, `dados-estruturados.md`). O bloco continua valendo pelo usuário e pela citação por IA.
- Definição limpa da entidade principal em uma frase (alimenta knowledge graph e citação por IA — `aio-llmo-geo.md`).

**VETADO**
- FAQ inventada só pra encaixar schema; tabela renderizada como imagem (ilegível pra busca e IA).

---

## Checklist on-page (por página, pré-publicação)

**Title & meta**
- [ ] `<title>` único no site, ~50–60 char / ≤~600px, keyword primária no começo, marca no fim
- [ ] `<meta name="description">` própria, ~150–160 char, com keyword e CTA
- [ ] Title e description no idioma correto da página

**Headings**
- [ ] Exatamente um `<h1>`, expressando a intenção da página
- [ ] Hierarquia `h1→h2→h3` sem pular nível; headings descritivos
- [ ] `h2`/`h3` com variações semânticas / perguntas do PAA quando cabe

**URL**
- [ ] Curta, minúscula, com hífen, com keyword, sem parâmetro/ID
- [ ] Estável (ou 301 no lugar se mudou)

**Semântica & conteúdo**
- [ ] `<main>` único; `<article>`/`<section>`/`<nav>` corretos; conteúdo em SSR/SSG
- [ ] Intenção respondida acima da dobra
- [ ] Keyword primária + variações/entidades, sem stuffing; profundidade adequada, sem thin
- [ ] Ângulo distinto do domínio (nada copiado de outro domínio da casa)

**Mídia**
- [ ] `alt` descritivo (ou vazio se decorativa); nome de arquivo com hífen
- [ ] `width`/`height`/`aspect-ratio` declarados; LCP não é lazy

**Links & snippets**
- [ ] Âncoras internas descritivas (nada de "clique aqui"), apontando pra canônica
- [ ] Ligada ao cluster; link de conversão pro `.net` quando aplicável
- [ ] Parágrafo-resposta / lista / tabela para snippet e extração por IA

**Não-canibalização (multi-domínio)**
- [ ] Nenhuma outra página (mesmo domínio ou entre domínios) disputa esta intenção com title/H1/conteúdo iguais
- [ ] Página é self-canonical (nunca canonical cruzado entre `.net`/`.org`/`.me`/`.com.br` — ver `tecnico.md` e `internacional-multidominio.md`)

> Validação final da página passa pelo `checklist-lp.md`. Baseline e pós-mudança em `medicao.md`.
