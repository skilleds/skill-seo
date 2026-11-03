---
description: schematize-seo — gera o handoff (context.md + checklist.md) no archive SEM compactar — pra fim de sessão
---

Gere o handoff **sem** compactar (fim de sessão, troca de máquina, entrega para outra pessoa):

1. `<projeto>/<projeto>_archive/context/<YYYY-MM-DD-HH-MM-SS>-context.md` — o mesmo conteúdo do
   `/seo-cc` (páginas analisadas, **baseline com data**, decisões de intenção/cluster, redirects,
   onde parou).
2. `<projeto>/<projeto>_archive/context/<YYYY-MM-DD-HH-MM-SS>-checklist.md` — **FEITO vs EM
   ABERTO**, por página.
3. **Não** rode `/compact`.

> SEO é a disciplina em que o efeito aparece **semanas depois**: sem o handoff com baseline datado,
> a próxima sessão não consegue nem dizer se o que foi feito funcionou.
