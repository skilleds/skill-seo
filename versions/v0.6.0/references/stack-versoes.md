# Anexo volátil — o que o Google mudou e quando foi conferido

> Parte da skill **schematize-seo**. **Fonte volátil.** Em SEO, quase tudo é volátil: rich result
> some, relatório do GSC é desativado, nome de produto muda. Este anexo existe para que o corpo
> normativo diga **princípio** e nunca **estado do produto Google** — o lint do catálogo (regra
> `anexo-volatil`) reprova fato datado cravado fora daqui.
>
> **Verificado em: 2026-08-21.** Cadência: **revisão trimestral**, e sempre antes de um release.
> Fontes: `developers.google.com/search` (changelog + galeria de rich results) e
> `genai.owasp.org` para o recorte de IA.

## Rich results — o que MORREU (não marque; remova se estiver marcado)

| Feature | Estado (verificado em 2026-08-21) |
|---|---|
| **`FAQPage`** | **MORTO.** (Reverificado em 2026-10-14.) Depreciação anunciada e exibição encerrada em **07/05/2026** (a data "08/05" anterior era incoerente; a data exata do anúncio varia entre fontes secundárias <!-- reverificar -->); documentação removida em 12/06/2026. |
| **`HowTo`** | **MORTO.** Fora da galeria de rich results. |
| **sitelinks searchbox** (`SearchAction` em `WebSite`) | **MORTO.** Fora da galeria; a marcação não gera mais a caixa de busca. |

**O que NÃO morre com eles:** o **conteúdo**. Bloco de Q&A e passo a passo continuam servindo ao
usuário e continuam sendo dos formatos mais **citáveis por resposta de IA** (`aio-llmo-geo.md`).
O que sai é a expectativa de rich result e o esforço de marcação por causa dela.

## Ferramentas e relatórios que deixaram de existir

| O quê | Estado |
|---|---|
| **International Targeting** (targeting geográfico no GSC) | **desativado em 2022.** Não existe mais o botão. Geo para gTLD vem de hreflang recíproco + `x-default`, idioma/moeda do conteúdo, endereço/telefone reais marcados, e links locais. |
| **"SGE"** | nome morto (era o experimento). Os nomes vivos são **AI Overviews** e **AI Mode** (2025). |

## A regra que NÃO é volátil

- Nunca black-hat/cloaking; toda página indexável é **self-canonical** com **uma** intenção;
  **nunca canonical cruzado** entre domínios distintos da casa; **hreflang recíproco**; medir
  antes/depois. Isso não muda quando o Google muda — mora no corpo normativo.
- **Antes de prescrever um tipo de dado estruturado, confira a galeria** e registre a data aqui.
  A galeria **encolhe**, e o que encolheu não avisa quem já tinha escrito.
