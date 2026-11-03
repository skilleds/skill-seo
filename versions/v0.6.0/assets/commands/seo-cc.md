---
description: Context Compact — gera handoff (context.md + checklist.md) no <projeto>_archive e compacta
---

Antes de compactar, **arquive o handoff** (não perca o estado do trabalho de SEO):

1. `<projeto>/<projeto>_archive/context/<YYYY-MM-DD-HH-MM-SS>-context.md` — estado: quais
   páginas/URLs foram analisadas, **baseline medido** (posição, impressões, CWV — com a data da
   coleta), decisões de intenção/cluster tomadas, redirects planejados ou aplicados, e o que
   estava em andamento.
2. `<projeto>/<projeto>_archive/context/<YYYY-MM-DD-HH-MM-SS>-checklist.md` — **FEITO vs EM
   ABERTO**, por página: intenção declarada · title/description/H1 · self-canonical · hreflang
   recíproco · dados estruturados válidos · conteúdo citável · CWV · baseline registrado.
3. Só então rode `/compact` (foco na tarefa corrente).

**Não perca o baseline.** Ele é o único jeito de dizer depois se a mudança funcionou — e é a
primeira coisa que some numa compactação.
