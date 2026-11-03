---
description: Gate de SEO de uma página/PR (title/meta/H1/URL/canonical/hreflang/schema/alt)
argument-hint: "[url, arquivo ou ref git]"
---

Faça o **review de SEO** de $ARGUMENTS (uma página, um arquivo de página, ou o diff
atual). Combine leitura do conteúdo com o gate de pisos da skill.

Primeiro rode o gate de máquina sobre o build (`bash scripts/check-seo.sh <dir>`; exit 1 = `BLOQUEIA`). Depois rode contra `references/checklist-lp.md` e reprove o que quebra piso (ver `SKILL.md`):

- **Intenção & keyword**: uma intenção dominante; sem canibalizar outra URL/domínio.
- **On-page**: title único ~55char keyword-first; meta ~155char com CTA; **UM** H1;
  headings hierárquicos; URL limpa; conteúdo responde acima da dobra; `alt` nas imagens;
  âncoras internas descritivas.
- **Técnico**: `rel=canonical` **self**, absoluto, sem cross-domain indevido; indexável
  e no sitemap; sem redirect chain/soft-404; Core Web Vitals verde; mobile ok; HTTPS.
- **Dados estruturados**: JSON-LD do tipo certo, **válido**, refletindo o conteúdo visível
  (nada de FAQPage sem FAQ na página).
- **Internacional/multi-domínio**: domínio certo pro propósito; self-canonical; hreflang
  recíproco **só** se for tradução do mesmo conteúdo; links de conversão → `.net`.
- **AIO/IA**: parágrafo-resposta extraível; entidade/`sameAs`; `llms.txt` coerente.
- **Autoridade/E-E-A-T**: autoria quando aplicável; links internos de páginas fortes.
- **Medição**: página na propriedade GSC certa; evento de conversão; baseline registrado.

Produza um relatório com `BLOQUEIA` (viola piso) e `ATENÇÃO` (melhorar), cada item com
arquivo/URL e o **conserto concreto**. Qualquer `BLOQUEIA` → a LP **não publica**.
