---
description: schematize-seo — cria ou ATUALIZA o CLAUDE.md da raiz do repositório com o bloco de SEO da skill; faz backup se houver customização local
---

Instale (ou atualize) o bloco **sempre-on** de SEO no `CLAUDE.md` da **raiz do repositório**:

1. Leia `.claude/skills/schematize-seo/assets/CLAUDE.md` (ou `~/.claude/skills/...`).
2. **Se não existir `CLAUDE.md` na raiz:** crie com esse conteúdo, ajustando `<domínio>`.
3. **Se já existir:**
   - faça **backup** (`CLAUDE.md.bak-<YYYY-MM-DD-HH-MM-SS>`) antes de qualquer escrita;
   - **mescle**, não sobrescreva: substitua apenas o bloco de SEO (do heading
     `# CLAUDE.md — SEO da Casa` até o próximo heading de mesmo nível), preservando
     **integralmente** os blocos das outras skills (`schematize-web`, a de backend, etc.);
   - se houver customização local **dentro** do bloco de SEO, mostre o diff e **pergunte** antes de
     substituir.
4. Confirme em uma linha o que foi criado/atualizado e onde ficou o backup.

> **Por que o arquivo existe:** o `anti-padroes.md` desta skill declara MUST o *"contexto pinado em
> toda tarefa"* — e, até 2026-08-21, a `schematize-seo` era **a única skill do catálogo sem
> `assets/CLAUDE.md`**: o arquivo que pina não existia.
