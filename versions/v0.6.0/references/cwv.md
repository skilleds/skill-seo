# SEO Técnico — Core Web Vitals e Mobile-first

> Parte da skill **schematize-seo** — CWV como fator de SEO e mobile-first indexing (§7–8). Índice em `tecnico.md`; as numerações de seção (§) foram preservadas.

## 7. Core Web Vitals como fator de SEO

Core Web Vitals são **fator de rank** (page experience) e afetam extração por IA. O SEO **exige o resultado no verde**; a **implementação delega ao `schematize-web`**.

| Métrica | O que mede |
|---|---|
| **LCP** (Largest Contentful Paint) | Carregamento do maior elemento |
| **INP** (Interaction to Next Paint) | Resposta à interação |
| **CLS** (Cumulative Layout Shift) | Estabilidade visual |

> Limiares, janela de 28 dias do CrUX e o estado do INP: `schematize-web → references/stack-versoes.md` (seção "Core Web Vitals").

> **Os NÚMEROS não moram aqui.** Threshold de CWV é fato com prazo de validade (o INP substituiu o
> FID em 2024; os valores são revistos pelo Google), e ele já vivia no **anexo volátil da
> `schematize-web`** (`references/stack-versoes.md`, com data de verificação). Duplicá-los aqui
> significava **duas fontes divergindo em silêncio** — e a desta skill, sem data, apodrecendo
> primeiro (achado da Classe F da vistoria de 2026-08-21). **Fonte única:** `schematize-web` →
> `references/stack-versoes.md`, seção "Core Web Vitals".

**MUST**
- Medir com **dados de campo** (CrUX/GSC), não só lab (Lighthouse). O rank usa campo.
- CWV fora do verde em página que importa é dívida de SEO — abre tarefa no `schematize-web` (imagem de LCP com prioridade, sem lazy no herói; JS enxuto pra INP; dimensões declaradas pra CLS — ver anti-padrões de performance do web).

---

## 8. Mobile-first indexing

**MUST**
- O Google indexa a versão **mobile** do site. O que valer pra SEO — conteúdo, headings, links internos, dados estruturados, metadados — **existe e é idêntico no mobile**. Nada de "versão mobile enxuta" que corta conteúdo ou links.
- Sem viewport quebrada, sem conteúdo escondido em accordion que não vem no HTML, sem alvos de toque inviáveis (liga com `schematize-web`, mobile utilizável como gate).

