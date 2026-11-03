# SEO Técnico — Crawl, Indexação, Status, Canonical, HTTPS e Render

> Parte da skill **schematize-seo** — o que o crawler consegue rastrear, o que entra no índice, status/redirects, canonical, HTTPS e render JS (§1–6). Índice em `tecnico.md`; as numerações de seção (§) foram preservadas.

## 1. Crawlability — deixar o crawler entrar e não desperdiçar

O funil começa em **rastrear**. Se o Googlebot não chega na URL, nada mais importa.

### 1.1 robots.txt

**MUST**
- Existe **um** `robots.txt` na raiz de **cada** propriedade (`https://schematize.net/robots.txt`, `https://schematize.org/robots.txt`, etc.), servido com `200` e `Content-Type: text/plain`.
- Declara a directive `Sitemap:` com **URL absoluta** do sitemap (ou do sitemap index) — uma linha por sitemap.
- Sintaxe correta: `User-agent`, `Disallow`, `Allow`. Path é case-sensitive e relativo à raiz. `Disallow:` vazio = libera tudo; `Disallow: /` = bloqueia tudo.

**Sintaxe de referência:**

| Objetivo | Linha |
|---|---|
| Todos os bots | `User-agent: *` |
| Bloquear uma pasta | `Disallow: /admin/` |
| Bloquear por padrão | `Disallow: /*?sessionid=` |
| Abrir exceção dentro de bloqueio | `Allow: /admin/public/` |
| Apontar o sitemap | `Sitemap: https://schematize.net/sitemap.xml` |

**O que bloquear vs. liberar:**

| Bloquear no robots.txt | Liberar (nunca bloquear) |
|---|---|
| Áreas privadas/admin, carrinho, checkout, conta | Páginas que devem rankear |
| Busca interna e facetas infinitas (crawl trap) | **CSS e JS** — o Googlebot precisa deles pra renderizar (ver §6) |
| Endpoints de API internos sem valor de busca | Imagens que devem aparecer no Google Imagens |
| Ambientes de staging/preview (idealmente atrás de auth) | O próprio sitemap |

**VETADO**
- **Bloquear CSS/JS no robots.txt.** Impede o render e derruba mobile-first e Core Web Vitals aos olhos do Google.
- **Usar robots.txt para "esconder" uma página do índice.** Ele controla *rastreio*, não *indexação* — ver §2.1, a diferença é crítica.
- **`Disallow: /` em produção** (bloqueia o site inteiro — o clássico "esqueceu de tirar do deploy de staging").

### 1.2 Crawl budget

**SHOULD**
- Tratar crawl budget só é relevante em site **grande** (dezenas de milhares de URLs) ou com muita URL de baixo valor. Site pequeno/médio não tem problema de budget — tem problema de qualidade.
- Reduzir desperdício: eliminar crawl traps (facetas/ordenações infinitas via parâmetro), consolidar redirects (§3.2), servir `304 Not Modified` quando cabível, e evitar milhares de URLs quase-duplicadas.
- Não gastar rastreio com URL que retorna `noindex` repetidamente — a longo prazo o Google rastreia menos, o que atrasa descoberta do que importa.

---

## 2. Indexação — controlar o que entra no índice

### 2.1 `noindex` vs `Disallow` — a diferença CRÍTICA

Esta é a confusão que mais quebra SEO técnico. Os dois **não** são intercambiáveis:

| | `Disallow` (robots.txt) | `noindex` (meta/header) |
|---|---|---|
| Controla | **Rastreio** (o bot não busca a página) | **Indexação** (o bot busca, mas não indexa) |
| A página aparece no índice? | **Pode aparecer** (sem snippet, "descoberta por links") | **Não aparece** |
| O bot lê o conteúdo? | Não | Sim |
| Uso correto | Poupar budget em massa de URLs sem valor | Tirar UMA página específica do índice |

**Regra de ouro (MUST):** para **remover uma página do índice**, use `noindex` e **deixe o robots.txt LIBERAR o rastreio dessa URL**. Se você bloqueia no robots.txt, o Google **nunca lê** a tag `noindex` — e a URL pode continuar indexada (aparecendo como resultado sem descrição, "descoberta por links externos"). São mutuamente excludentes na prática: `noindex` só funciona se a página for rastreável.

**Como aplicar `noindex`:**
- HTML: `<meta name="robots" content="noindex, follow">` no `<head>`.
- Header (para PDF, imagens, respostas não-HTML): `X-Robots-Tag: noindex`.
- `follow` mantém o fluxo de link saindo da página; use `noindex, follow` salvo motivo pra `nofollow`.

**Quando usar `noindex`:** busca interna, páginas de agradecimento/confirmação, paginação duplicada, filtros que geram thin content, versões de impressão. **Quando usar `Disallow`:** áreas privadas, admin, seções sem qualquer valor de busca onde nem queremos gastar rastreio.

**VETADO**
- `noindex` **e** `Disallow` na mesma URL esperando remoção — o `Disallow` cega o bot pro `noindex` e a página pode ficar presa no índice.
- `noindex` acidental em página que deveria rankear (o erro mais caro do deploy — sempre auditar antes de publicar).

### 2.2 Indexabilidade intencional

**MUST**
- Toda página que **deve** rankear é: rastreável (não bloqueada), indexável (sem `noindex`), self-canonical pra si (§4), com resposta `200`, e com conteúdo no HTML servido (§6).
- Toda página que **não deve** rankear (staging, carrinho, filtros infinitos, duplicatas) é explicitamente `noindex` ou bloqueada — nunca "por acaso".

---

## 2.3 Controlar o SNIPPET — o que aparece na SERP e o que a IA pode citar

Indexar e **exibir** são coisas diferentes, e a maioria dos times só conhece a primeira. Estes são
**os únicos controles que afetam diretamente o que os buscadores e os answer engines mostram** do
seu conteúdo — e eles vivem na mesma `<meta name="robots">` / header `X-Robots-Tag`:

| Diretiva | O que faz |
|---|---|
| `nosnippet` | **nenhum** trecho na SERP (e, na prática, remove o texto que alimentaria a resposta de IA daquela página) |
| `max-snippet:[n]` | teto de **caracteres** do trecho. `0` equivale a `nosnippet`; **`-1`** = sem limite |
| `data-nosnippet` | **atributo HTML** (`<span data-nosnippet>`) que exclui **um pedaço** da página — o resto continua elegível |
| `max-image-preview:[none\|standard\|large]` | tamanho da miniatura; **`large` é requisito prático** para aparecer bem em Discover e em resultado visual |
| `max-video-preview:[n]` | segundos de preview de vídeo |
| `noarchive` | sem cópia em cache |

**MUST**
- **Decida por tipo de página**, e escreva a decisão: conteúdo de topo de funil normalmente quer
  **`max-snippet:-1` + `max-image-preview:large`** (ser citado é o objetivo); conteúdo **pago ou
  sob login** usa `max-snippet:[n]` curto ou `data-nosnippet` no bloco premium — **e é aí que
  `data-nosnippet` ganha do `nosnippet`**: você esconde o trecho pago sem apagar a página da SERP.
- **`nosnippet` é uma faca de dois gumes:** sem trecho, o CTR cai — e, com AI Overviews, sem texto
  citável você some da resposta em vez de aparecer melhor.
- **Estas diretivas são de EXIBIÇÃO, não de indexação.** Nenhuma delas tira a página do índice
  (isso é `noindex`), e nenhuma delas impede o crawl (isso é `robots.txt` — que, aliás, **não** é
  como se tira algo do índice).
- **Crawler de IA é outra decisão**, e ela é de negócio: bloquear `GPTBot`/`ClaudeBot`/`PerplexityBot`
  no `robots.txt` protege o conteúdo **e** o remove das respostas onde ele seria citado. Registre em
  ADR — em `aio-llmo-geo.md` está o detalhe.

**VETADO**
- Usar `robots.txt` para "tirar do Google": página bloqueada **não pode ser lida**, logo o `noindex`
  dela **nunca é visto** — e ela pode continuar aparecendo, só que sem trecho. Para remover, deixe
  rastrear e use `noindex`.

## 3. Status HTTP e redirects

### 3.1 Códigos de status e o que o SEO faz com eles

| Código | Significado | Efeito no índice |
|---|---|---|
| `200` | OK | Indexável (se não houver `noindex`/canonical apontando pra fora) |
| `301` | Movido permanente | **Para mover URL.** Consolida sinais no destino. É o redirect de SEO |
| `302` | Movido temporário | Mantém a URL antiga no índice. Só pra movimento realmente temporário |
| `304` | Not Modified | Economiza budget; conteúdo inalterado desde o `If-Modified-Since` |
| `404` | Não encontrado | Sai do índice com o tempo. Correto pra conteúdo que não existe |
| `410` | Gone | Como `404`, porém sinaliza remoção **definitiva** — sai mais rápido |
| `5xx` | Erro de servidor | Grave: repetido, o Google reduz rastreio e pode desindexar. Monitorar |

**MUST**
- Mover URL permanentemente → **`301`**. Nunca deixar a URL antiga responder `200` com o mesmo conteúdo em duas URLs (duplicação).
- Conteúdo removido de vez → **`410`** (ou `404`). Nunca `301` em massa de páginas mortas pra home — isso é *soft-404* mascarado (ver abaixo).
- `5xx` recorrente é incidente de SEO, não só de infra — alertar.

### 3.2 Regras de redirect

**MUST**
- **Uma versão canônica do host, sempre `301` para ela:** decidir HTTPS (obrigatório, §5), `www` ou apex, e redirecionar todas as outras variantes pra ela. Ex.: `http://`, `www.`, e trailing-slash inconsistente convergem pra **uma** forma.
- **Nunca cadeia de redirect** (`A→B→C`). Aponte a origem direto pro destino final (`A→C`). Cada salto perde sinal e budget.
- **Nunca loop de redirect** (`A→B→A`). Quebra o rastreio.

**VETADO**
- **Soft-404** — página que responde `200` mas diz "não encontrado"/"produto indisponível" no corpo, ou `301` de conteúdo morto pra home. O Google trata como erro e desconfia do site inteiro. Conteúdo que não existe responde `404`/`410`; página vazia legítima mostra estado vazio útil **e** responde o status certo.
- Redirecionar em massa páginas descontinuadas pra home "pra não perder o 404" — pior que o 404.

> A **estratégia de "links que importam"** (quando `.org`/`.me`/`.com.br` remetem tráfego/autoridade pro `.net` de conversão) é feita por **link**, não por redirect nem canonical cruzado. Ver `internacional-multidominio.md`.

---

## 4. Canonical

**MUST**
- **Toda página indexável tem `<link rel="canonical">` self-referente** (aponta pra si mesma), com **URL absoluta** (`https://schematize.net/pagina`, não `/pagina`).
- A canônica usa **uma versão só**: HTTPS, host decidido (www vs apex), **sem parâmetros de tracking** (`utm_*`, `gclid`, `fbclid`, `sessionid`) e sem barra final inconsistente.
- Variações da mesma página (por query de tracking, ordenação, filtro leve) apontam canonical pra versão limpa.
- Canonical é **dica forte**, não ordem — reforce com sitemap, internal linking e `301` coerentes. Contradizer o canonical com um `301` ou um `noindex` confunde o Google.

**VETADO — piso da casa**
- **Canonical cruzado entre os domínios distintos da casa.** `.net`, `.org`, `.me` e `.com.br` têm conteúdo e intenção **distintos**; cada um é **self-canonical**. Canonicalizar `.me`→`.net` jogaria fora a autoridade do `.me`. As propriedades se diferenciam por conteúdo e se conectam por **links**, nunca por canonical. Detalhe e exceções (versões idênticas, sindicação) em `internacional-multidominio.md`.
- Canonical apontando pra URL que retorna `404`, `noindex` ou redirect — sinal quebrado, ignorado.
- Página com canonical pra outra e ao mesmo tempo no sitemap como canônica — contradição.

---

## 5. HTTPS

**MUST**
- Site **inteiro** em HTTPS. HTTP é fator de rank negativo e marca "não seguro" no browser.
- Todo HTTP → `301` pra HTTPS. Sem *mixed content* (recurso HTTP dentro de página HTTPS).
- `Strict-Transport-Security` (HSTS) com `max-age` longo. Certificado válido e renovado automaticamente (implementação no `schematize-web`/ops).

---

## 6. JS e render SEO

O Googlebot **rasteia**, depois **renderiza** (executa JS numa fila, com atraso). O que não estiver no HTML **servido** depende dessa segunda passada — que pode demorar, falhar ou não acontecer para outros bots (incl. muitos crawlers de IA, ver `aio-llmo-geo.md`).

**MUST**
- **Conteúdo que precisa rankear vem no HTML do servidor** — **SSR** ou **SSG**. Título, H1, corpo, links internos e dados estruturados presentes na resposta inicial, sem depender de execução de JS no cliente.
- Testar o que o crawler realmente vê: "Inspeção de URL" no GSC (HTML renderizado), `curl` da página, ou visualizar com JS desabilitado. Se o conteúdo some sem JS, é problema de SEO.

**VETADO**
- **Conteúdo só-em-JS (CSR puro)** para páginas que devem rankear — SPA que serve `<div id="root"></div>` vazio e monta tudo no cliente. Corpo, links e metadados ficam invisíveis na primeira passada e frágeis para bots que não renderizam.
- **Links de navegação por `onClick`/JS** sem `<a href>` real — o crawler não os segue. Todo link rastreável é `<a href>` com URL de verdade (liga com a11y no `schematize-web`).
- Injetar `<title>`/canonical/hreflang **só** via JS no cliente — declarar no HTML servido.

| Estratégia | Rankeia bem? | Uso |
|---|---|---|
| **SSG** (estático) | Sim | Conteúdo estável: landing, blog, docs, institucional |
| **SSR** | Sim | Conteúdo dinâmico/personalizado que ainda precisa indexar |
| **ISR / SSG + revalidate** | Sim | Grande volume que atualiza periodicamente |
| **CSR puro** (SPA) | **Não** para conteúdo público | App logado atrás de auth — que nem deve indexar |

> Escolha de SSG vs SSR vs ISR e implementação: `schematize-web`.

