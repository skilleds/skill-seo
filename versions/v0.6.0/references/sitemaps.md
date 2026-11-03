# SEO Técnico — Sitemaps XML e Além do Google

> Parte da skill **schematize-seo** — sitemaps e limites das ferramentas (§10–11). Índice em `tecnico.md`; as numerações de seção (§) foram preservadas.

## 10. Sitemaps XML

> A regra da casa é: **sitemap nunca é mantido à mão** — é **gerado** da fonte da verdade (varredura do build ou inventário de rotas/CMS) a cada deploy. Implementação e scaffold no `schematize-web` (`references/seo-i18n.md`, `scripts/gen-sitemap.mjs`). Aqui está o *o quê* incluir.

**MUST**
- Sitemap XML válido listando as URLs **canônicas** que devem ser indexadas.
- **`<loc>`** com URL absoluta, HTTPS, forma canônica (sem tracking, host decidido).
- **`<lastmod>`** com a data **real** da última modificação relevante do conteúdo (ISO 8601). `<lastmod>` mentiroso (mudar em todo deploy sem mudar conteúdo) faz o Google ignorá-lo.
- **Sitemap index** (`<sitemapindex>`) quando passar de **50.000 URLs** ou **50 MB** (descomprimido) por arquivo — quebrar em vários e referenciar por um índice.
- Registrar o sitemap no `robots.txt` (`crawl-index.md` §1.1) e **submeter no Google Search Console**.

**O que incluir vs. excluir:**

| Incluir no sitemap | Excluir do sitemap |
|---|---|
| URLs canônicas, `200`, indexáveis | URLs com `noindex` |
| Conteúdo publicado que deve rankear | URLs bloqueadas por robots.txt |
| — | Não-canônicas (que apontam canonical pra outra) |
| — | Redirects (`301`/`302`), `404`/`410`, parâmetros de tracking |

**MUST — i18n no sitemap**
- Em site multilíngue, cada URL lista suas alternativas por idioma com `xhtml:link rel="alternate" hreflang="..."`, **recíprocas** e com `x-default`. hreflang e multi-domínio em `internacional-multidominio.md`.

**VETADO**
- Sitemap com URL `noindex`, redirecionada ou `404` (sinal contraditório — a URL do sitemap "quer" indexar, a página diz o contrário).
- Sitemap estático mantido à mão que dessincroniza do site (`anti-padroes.md`).

---

## 11. Além do Google — e os limites das ferramentas

- **`robots.txt` é padrão (RFC 9309)**, não convenção de um buscador: sintaxe, precedência do grupo
  mais específico e o fato de que **bloquear ≠ remover do índice** valem para todos. O que **não** é
  padronizado (`Crawl-delay`, wildcard em alguns crawlers) precisa ser verificado por bot.
- **Bing/IndexNow:** o **IndexNow** notifica Bing, Yandex e parceiros quando uma URL **muda** — é
  barato (um `POST` com a chave hospedada no domínio) e vale para site com publicação frequente.
  **Não** é canal do Google, e **não** substitui sitemap: é *push* de mudança, não inventário.
- **Google Indexing API** só é sancionada pelo Google para **`JobPosting`** e **vídeo ao vivo
  (`BroadcastEvent`)** — usá-la para conteúdo comum é uso fora da política, com risco de ação
  manual; para o resto, o caminho é sitemap + link interno.
- **Sitemap de imagem e de vídeo** (extensões `image:`/`video:`) são o que faz mídia entrar na busca
  vertical; num site com catálogo visual, é a diferença entre aparecer e não aparecer em
  Imagens/Vídeo.
- **O GSC guarda 16 meses de dados de desempenho — e só.** Comparação ano a ano **morre** aos 16
  meses; se a medição da casa depende de série histórica (e ela depende — `medicao.md`), **exporte
  mensalmente** para armazenamento próprio. Descobrir isso no dia em que você precisa do dado de 18
  meses atrás é descobrir tarde demais.

