---
description: Auditoria SEO (técnico, on-page, schema, CWV, multi-domínio, AIO) plan-first
argument-hint: "[url ou caminho do projeto]"
---

Faça uma **auditoria de SEO** de $ARGUMENTS (ou do site/projeto atual), plan-first.

1. **Planeje** o escopo e mostre antes de rodar: quais propriedades/URLs, e quais
   frentes serão checadas. Peça aprovação.

2. **COLETE ANTES DE JULGAR — não afirme nada que você não viu.** Esta é a diferença entre
   auditoria e chute. Para **cada URL do escopo**, colete e mostre o dado bruto:

   ```bash
   # a) status, redirects e headers (segue a cadeia e mostra cada salto)
   curl -sSIL -o /dev/null -w '%{url_effective} -> %{http_code} (%{num_redirects} saltos)\n' "$URL"
   curl -sSI "$URL" | grep -iE 'x-robots-tag|content-type|cache-control|link:'

   # b) o HTML SERVIDO (o que o crawler que não executa JS enxerga)
   mkdir -p .schematize/tmp && curl -sSL "$URL" -o .schematize.schematize/tmp/pagina.html
   grep -oiE '<title>[^<]*</title>|<link[^>]+rel="canonical"[^>]*>|<meta[^>]+name="(robots|description)"[^>]*>|<link[^>]+hreflang="[^"]*"[^>]*>|<h1[^>]*>.*</h1>' .schematize/tmp/pagina.html

   # b2) gate de máquina sobre o HTML coletado (mesmo script do piso; não use regex própria)
   bash scripts/check-seo.sh --host "$HOST_DO_SITE" .schematize/tmp/   # multi-domínio: --host a,b

   # c) dados estruturados que realmente saíram no HTML
   grep -oE '<script[^>]+application/ld\+json[^>]*>[^<]*' .schematize/tmp/pagina.html

   # d) robots.txt e sitemap — existem? o sitemap lista esta URL?
   curl -sS "$ORIGEM/robots.txt"
   curl -sS "$ORIGEM/sitemap.xml" | grep -c '<loc>'
   ```

   **Regras da coleta:**
   - **Sem resposta HTTP, não há veredito.** Se a coleta falhou (rede, auth, alvo local não
     servido), **diga que não conseguiu** e marque a frente como *não auditada* — nunca
     "canonical OK" por leitura de código-fonte. *(Este comando descrevia as frentes em prosa,
     sem uma única instrução de coleta: o modelo afirmava "canonical OK" sem ter visto uma
     resposta HTTP — achado da vistoria de 2026-08-21.)*
   - **Compare servido × renderizado** quando houver JS: o que só aparece depois da hidratação é
     invisível para boa parte dos crawlers de IA.
   - **Canibalização e hreflang exigem MAIS DE UMA URL** — colete todas as candidatas antes de
     concluir, e mostre a matriz.
   - **CWV e a11y vêm de campo/ferramenta** (GSC/CrUX, Lighthouse), não de leitura: se não tem o
     número, a frente é *não auditada*.
   - **Registre a data e a URL efetiva** de cada coleta no relatório — auditoria sem data não é
     comparável com a próxima.

3. **Rode a auditoria** por frente, **sobre o que você coletou**, lendo o reference correspondente
   antes de cada uma:
   - **Técnico** (`references/tecnico.md` e os arquivos que ele indexa): robots.txt, sitemap, canonical (self,
     absoluto, sem cross-domain indevido), status/redirects (sem cadeia/soft-404),
     indexabilidade (noindex/disallow corretos), arquitetura/profundidade, internal
     linking/orphans, HTTPS, mobile-first, JS/render (conteúdo visível ao crawler).
   - **On-page** (`references/on-page.md`): title único keyword-first, meta com CTA,
     UM H1/uma intenção, URL limpa, HTML semântico, alt, âncoras internas.
   - **Keywords/conteúdo** (`references/keywords-conteudo.md`): intenção por URL,
     **canibalização** (URLs disputando a mesma query), thin/duplicado.
   - **Dados estruturados** (`references/dados-estruturados.md`): JSON-LD do tipo
     certo, válido, refletindo o conteúdo visível.
   - **Internacional/multi-domínio** (`references/internacional-multidominio.md`):
     domínio certo pro propósito, self-canonical, hreflang recíproco só se tradução,
     conversão apontando pro `.net`, marca como entidade única (`sameAs`).
   - **AIO/IA** (`references/aio-llmo-geo.md`): conteúdo extraível/citável, `llms.txt`,
     política de crawler de IA, entidade.
   - **Core Web Vitals & a11y** (delega ao `schematize-web`): exija o resultado (verde).
4. **Relatório priorizado**: liste achados como `BLOQUEIA` (viola piso — ver
   `SKILL.md`) e `ATENÇÃO` (melhoria), cada um com o conserto concreto e o impacto
   estimado (alcance × esforço). Feche com a ordem recomendada de execução.

Seja específico e acionável. Se faltar acesso a GSC/analytics, diga o que medir
depois (`references/medicao.md`) pra fechar o baseline.
