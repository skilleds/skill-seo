---
description: schematize-seo — lista todos os comandos disponíveis e o que cada um faz
---

Mostre ao usuário a lista de comandos do conjunto **schematize-seo**, em formato
de tabela legível, exatamente com este conteúdo (ajuste se houver comandos novos
instalados em `.claude/commands/`):

| Comando | O que faz |
|---|---|
| `/seo-help` | Lista todos os comandos do schematize-seo (este). |
| `/seo-audit` | Auditoria SEO de um site/página: técnico, on-page, dados estruturados, Core Web Vitals, internacional/multi-domínio e AIO — planeja, pede aprovação, entrega relatório priorizado (BLOQUEIA/ATENÇÃO). |
| `/seo-plan` | Plano de SEO de uma propriedade: mapa de intenção, topic clusters/pillar, arquitetura de URL, estratégia multi-domínio (net/org/me/com.br) e KPIs. |
| `/seo-keywords` | Pesquisa e mapa de keywords por intenção + agrupamento em clusters, com anti-canibalização (uma intenção por URL). |
| `/seo-review` | Revisa uma página/PR pelo gate de SEO (title/meta/H1/URL/canonical/hreflang/schema/alt/internal links) e reprova o que quebra piso. |

Depois da tabela, diga em uma linha que o detalhe normativo está na skill
`schematize-seo` (referências em `references/`), que a implementação de frontend
(metadata/sitemap/robots/CWV na prática, a11y) é escopo do `schematize-web`, e que
a regra de ouro multi-domínio é: cada domínio self-canonical, conteúdo distinto,
conversão apontando pro `.net` — nunca canonical cruzado (ver `internacional-multidominio.md`).

- `/seo-load` — carrega **à força** todo o corpo normativo de SEO e passa a aplicá-lo.
- `/seo-claude` — cria/atualiza o `CLAUDE.md` da raiz com o bloco sempre-on (mescla, com backup).
- `/seo-cc` — handoff **com o baseline medido** no archive + `/compact`.
- `/seo-handoff` — o mesmo handoff, **sem** compactar (fim de sessão).
