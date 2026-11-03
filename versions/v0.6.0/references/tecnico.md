# SEO Técnico — Crawl, Índice, Render e Arquitetura

> Parte da skill **schematize-seo**. Cobre a camada técnica: o que o crawler consegue **rastrear**, o que o buscador escolhe **indexar**, como ele **renderiza** o HTML e como a **arquitetura** do site distribui autoridade. É o piso sobre o qual `on-page.md`, `keywords-conteudo.md` e `dados-estruturados.md` operam — conteúdo excelente numa página que o Googlebot não rastreia, não indexa ou não renderiza **não rankeia**.
>
> A **estratégia multi-domínio** da casa (net/org/me/com.br sem canibalizar, sem canonical cruzado) vive em `internacional-multidominio.md` — aqui só aplicamos a regra técnica. A **implementação no frontend** (rotas do App Router, `metadata`, sitemap/robots autogerados, Core Web Vitals na prática, SSR/SSG) **delega ao `schematize-web`** — esta skill diz *o que exigir*; o web diz *como codar*.

## Como ler

- **MUST / Obrigatório** — regra. Desvio bloqueia publicação ou exige ADR.
- **SHOULD / Recomendado** — padrão. Desvio precisa de justificativa.
- **VETADO / Proibido** — piso. Não tem ADR de exceção. Burlar é incidente.

Os thresholds abaixo são concretos e verificáveis. "Está bom" não é status — ou passa o número, ou tem ADR.


---

## Índice (o arquivo foi dividido por coesão; as numerações § foram preservadas)

| Arquivo | Seções | Quando abrir |
|---|---|---|
| `crawl-index.md` | §1 Crawlability (robots.txt, crawl budget) · §2 Indexação (`noindex` vs `Disallow`, snippet) · §3 Status e redirects · §4 Canonical · §5 HTTPS · §6 JS e render | Googlebot não chega, não indexa ou não renderiza |
| `cwv.md` | §7 Core Web Vitals · §8 Mobile-first | Performance como fator de SEO (números: `schematize-web → references/stack-versoes.md`) |
| `arquitetura.md` | §9 Profundidade, silos, internal linking, paginação e facetas | Estrutura do site e distribuição de autoridade |
| `sitemaps.md` | §10 Sitemaps XML · §11 Além do Google (IndexNow, Indexing API, GSC 16 meses) | Inventário de URLs e ferramentas |
| `checklist-tecnico.md` | Checklist pré-publicação/auditoria | Antes de publicar e em auditoria |
