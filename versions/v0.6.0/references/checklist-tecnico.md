# Checklist técnico de SEO

> Parte da skill **schematize-seo**. Índice em `tecnico.md`.

## Checklist técnico (pré-publicação / auditoria)

Rode por propriedade (`.net`, `.org`, `.me`, `.com.br`) — cada uma é independente e self-canonical.

**Crawl & índice**
- [ ] `robots.txt` existe na raiz, responde `200`, sintaxe válida, com `Sitemap:` absoluto
- [ ] robots.txt **não** bloqueia CSS/JS nem páginas que devem rankear
- [ ] Staging/preview bloqueado ou atrás de auth (sem `Disallow: /` vazado em prod)
- [ ] Páginas que devem rankear: rastreáveis, indexáveis, sem `noindex` acidental
- [ ] Páginas que não devem rankear: `noindex` (rastreável) **ou** `Disallow` — nunca os dois juntos esperando remoção

**Status & redirects**
- [ ] Uma versão canônica do host; HTTP→HTTPS, www/apex e trailing-slash convergem por `301`
- [ ] Sem cadeia (`A→B→C`) nem loop de redirect
- [ ] Conteúdo removido responde `404`/`410`; zero soft-404; `301` só pra destino equivalente
- [ ] Sem `5xx` recorrente

**Canonical**
- [ ] Toda página indexável com `<link rel=canonical>` self-referente, URL absoluta, sem tracking
- [ ] **Zero canonical cruzado** entre os domínios da casa (piso)
- [ ] Nenhum canonical aponta pra `404`/`noindex`/redirect

**HTTPS**
- [ ] Site 100% HTTPS, HSTS ativo, sem mixed content, certificado válido/auto-renovado

**Render / JS SEO**
- [ ] Conteúdo, H1, links internos e JSON-LD presentes no HTML **servido** (SSR/SSG)
- [ ] Página legível com JS desabilitado / "Inspeção de URL" do GSC mostra o conteúdo
- [ ] Links de navegação são `<a href>` reais, não `onClick` só-JS

**Core Web Vitals (campo, p75)**
- [ ] As três métricas no **verde**, medidas em **campo** (CrUX/GSC), no p75 — senão, tarefa no
      `schematize-web`. **Os números estão no anexo volátil da `schematize-web`**
      (`references/stack-versoes.md`, seção "Core Web Vitals", com data de verificação): repeti-los
      aqui recriaria a segunda fonte que esta skill acabou de eliminar — e seria a fonte sem data,
      a que apodrece primeiro.

**Snippet e exibição**
- [ ] A política de snippet foi **decidida por tipo de página** (`max-snippet`, `max-image-preview`,
      `data-nosnippet` no bloco pago) — e não herdada do default sem ninguém olhar.
- [ ] Nenhuma tentativa de tirar página do índice via `robots.txt` (bloqueado = `noindex` nunca lido).

**Mobile-first**
- [ ] Conteúdo/links/metadados/JSON-LD idênticos no mobile; viewport correta

**Arquitetura & internal linking**
- [ ] Profundidade ≤ 3 cliques até qualquer página importante
- [ ] Silos hub-spoke coerentes; breadcrumb visual + `BreadcrumbList`
- [ ] Âncoras descritivas; **zero orphan pages**; links pro `.net` onde há conversão

**Sitemaps**
- [ ] Sitemap gerado (não à mão), só URLs canônicas/`200`/indexáveis
- [ ] `<loc>` absoluto canônico, `<lastmod>` real, index acima de 50k URLs/50 MB
- [ ] Registrado no robots.txt e submetido no GSC; `hreflang`+`x-default` se multilíngue

---

**References irmãos:** `fundamentos.md` (como busca/IA rankeiam, o funil), `on-page.md` (title/meta/H1/URL/semântica), `keywords-conteudo.md` (intenção, topic clusters, anti-canibalização), `dados-estruturados.md` (schema.org/JSON-LD), `internacional-multidominio.md` (hreflang, self-canonical por propriedade, links que importam), `aio-llmo-geo.md` (descoberta por IA), `medicao.md` (GSC, logs, KPIs) e `anti-padroes.md` (black-hat + erros comuns). Implementação de frontend: **`schematize-web`**.
