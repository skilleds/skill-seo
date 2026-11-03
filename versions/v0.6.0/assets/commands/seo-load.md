---
description: schematize-seo — carrega à força TODO o corpo normativo de SEO (técnico, on-page, keywords/conteúdo, dados estruturados, internacional/multi-domínio, AIO/LLMO, medição, anti-padrões) e passa a aplicá-lo como regra inegociável
---

Carregue **à força** e passe a aplicar **integralmente** os Padrões de SEO da Casa (skill
`schematize-seo`) neste projeto. A partir de agora, nesta sessão, isto **não é opcional**.

1. **Leia agora, na íntegra, TODOS os references** — não trabalhe de memória. Caminho:
   `.claude/skills/schematize-seo/references/*.md` (projeto) ou
   `~/.claude/skills/schematize-seo/references/*.md` (global):
   - `fundamentos.md` — como a busca funciona, intenção, E-E-A-T, o que é (e o que não é) SEO.
   - `tecnico.md` (índice) + `crawl-index.md`, `cwv.md`, `arquitetura.md`, `sitemaps.md`, `checklist-tecnico.md` — crawl, indexação, render, canonical, redirects, arquitetura, internal linking,
     Core Web Vitals como fator de rank (os **thresholds** vivem no anexo volátil da
     `schematize-web`), JS SEO.
   - `on-page.md` — title, meta description, headings, URL, HTML semântico, mídia, âncoras.
   - `keywords-conteudo.md` — pesquisa, intenção, topic cluster/pillar, brief, anti-thin.
   - `dados-estruturados.md` — schema.org/JSON-LD, o que marcar, **e os rich results MORTOS**.
   - `internacional-multidominio.md` — os 4 domínios da casa sem canibalização, hreflang recíproco,
     self-canonical por propriedade, estratégia de redirect.
   - `aio-llmo-geo.md` — descoberta por IA: conteúdo citável, entidade, `llms.txt` (SHOULD),
     política de crawler, medição de citação.
   - `medicao.md` — GSC, analytics, rank, logs, KPIs, experimento com baseline.
   - `anti-padroes.md` — o que **queima o domínio**, com o caminho certo de cada um.
   - `autoridade-eeat.md` — E-E-A-T, autoridade e entidade por domínio.
  - `checklist-lp.md` — o checklist por landing page, pré-publicação.
   - `stack-versoes.md` — **anexo volátil**: o que o Google mudou e quando foi conferido.

2. **Confirme em uma linha** o que carregou (arquivos + data do anexo volátil).

3. **Passe a aplicar** os pisos como **inegociáveis** no resto da sessão: nunca black-hat; toda
   página indexável **self-canonical** com **uma** intenção; **nunca** canonical cruzado entre os
   domínios da casa; `hreflang` SÓ em tradução 1:1 do mesmo conteúdo (recíproco, com `x-default`), nunca entre conteúdos distintos; nenhum tipo de rich result **morto**
   marcado; e **medir antes/depois** — mudança sem baseline é opinião, não otimização.

4. **Fronteiras** (não invada): a **implementação** no frontend é da `schematize-web`; **quais
   páginas existem** num site de empresa é da `schematize-institutional`.

> Se algum reference não existir no caminho, **diga isso** em vez de seguir de memória — normativa
> que você não leu não é normativa que você aplica.
