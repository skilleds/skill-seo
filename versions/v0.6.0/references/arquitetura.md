# SEO Técnico — Arquitetura do Site, Internal Linking e Paginação

> Parte da skill **schematize-seo** — profundidade, silos, internal linking, paginação e facetas (§9). Índice em `tecnico.md`; as numerações de seção (§) foram preservadas.

## 9. Arquitetura do site

### 9.1 Profundidade e silos

**MUST**
- **Profundidade ≤ 3 cliques** da home a qualquer página importante. Quanto mais fundo, menos autoridade chega e mais tarde é rastreada.
- **Silos hub-and-spoke:** uma **pillar page** (hub) por tema linka pros artigos de apoio (spokes), e os spokes linkam de volta pro hub e entre si dentro do mesmo tema. Concentra relevância temática (topic clusters em `keywords-conteudo.md`).

**SHOULD**
- **Breadcrumb** em conteúdo hierárquico, visual **e** com `BreadcrumbList` estruturado (`dados-estruturados.md`). Ajuda usuário, crawler e o snippet.
- URL refletindo a hierarquia do silo (`/tema/subtema/pagina`) — desenho de URL em `on-page.md`.

### 9.2 Internal linking

**MUST**
- **Âncora descritiva** — o texto do link diz o destino ("guia de deploy em Rust"), nunca "clique aqui"/"saiba mais". A âncora é sinal de relevância pro Google e acessibilidade pro leitor de tela.
- **Zero orphan pages** — toda página indexável recebe pelo menos um link interno de outra página rastreável. Página só no sitemap, sem link de entrada, é órfã e rankeia mal.
- **Fluxo de autoridade dirigido:** páginas fortes (home, pillars) linkam pras que precisam subir; as "que importam" pra conversão recebem mais links internos.

**SHOULD**
- Poucos e bons links contextuais > dezenas de links de rodapé. Link no corpo do conteúdo pesa mais.
- Links **entre os domínios da casa** (`.org`→`.net`, `.me`→`.net`) são a forma correta de conectar propriedades e direcionar conversão pro `.net` — feito por link, não por canonical (§4, `internacional-multidominio.md`).

**VETADO**
- Orphan pages em produção; âncora genérica repetida; navegação principal só-JS que o crawler não segue (`crawl-index.md` §6).

---

## 9.1 Paginação e navegação facetada — onde o crawl budget vaza

Duas fontes de URL infinita, e as duas são de arquitetura, não de conteúdo:

- **Paginação.** `rel=next/prev` **não é mais usado pelo Google** (foi aposentado como sinal de
  indexação) — o que funciona hoje: cada página da série é **self-canonical** (nunca canonical para
  a página 1, que é o erro clássico e faz o item da página 7 sumir do índice), todas linkadas com
  `<a href>` real, e a página 1 sem parâmetro. Se existir uma **"ver tudo"** que carregue bem, ela
  pode ser a canônica.
- **Navegação facetada** (filtros combináveis: cor × tamanho × preço × ordenação) é a máquina de
  gerar **milhões de URLs quase iguais**. O piso: decida **quais facetas são indexáveis** (as que
  têm demanda de busca real e conteúdo distinto) e trate o resto com **`noindex,follow` + link sem
  `href` navegável** (ou POST/JS), **nunca** só `Disallow` — bloquear no `robots.txt` impede o
  crawler de **ler** o `noindex`, e a URL fica no índice sem trecho. Ordenação e paginação de
  faceta nunca são indexáveis.
- **Sintoma de que vazou:** o GSC mostra muito mais "Rastreada — não indexada" do que páginas reais,
  e o log de acesso mostra o bot passando o dia em combinação de filtro.

