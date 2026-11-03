# Checklist de SEO por página / Landing Page — o gate pré-publicação

> Parte da skill **schematize-seo**. Este arquivo é o **gate final antes de publicar uma LP**: o Definition of Done de SEO por página. Não é teoria — é a lista que se percorre item a item antes de mandar uma landing page pro ar. A disciplina que sustenta cada seção mora nos references-fonte linkados; aqui é a ponte acionável entre estratégia e publicação.

## Regra de ouro (leia antes de tudo)

**NENHUMA LP publica sem passar por este gate.** Não existe "publica rápido e ajusta o SEO depois" — depois é retrabalho, é canibalização já indexada, é autoridade queimada. Uma página só está pronta quando **todos** os itens obrigatórios abaixo estão marcados. Item que não se aplica se marca como N/A **com justificativa** — nunca em branco, nunca pulado no silêncio.

- **MUST / Obrigatório** — bloqueia a publicação. Falhou, não sobe.
- **SHOULD / Recomendado** — desvio precisa de justificativa registrada no PR/archive.
- Marque **cada** item. Um `- [ ]` aberto num MUST = LP **não publicável**.

Ordem de leitura: percorra as seções de cima pra baixo. As três primeiras (Intenção, On-page, Técnico) são o piso que zera as seguintes se falharem — não adianta ter schema perfeito numa página que não indexa nem responde à intenção certa.

---

## 1. Intenção & keyword

> Fonte: `keywords-conteudo.md`. Uma página, uma intenção — o piso nº 2 da casa.

**MUST**
- [ ] A LP tem **uma** intenção de busca dominante identificada (informational / navigational / commercial / transactional) — não duas.
- [ ] A **keyword primária** está definida e a intenção dela foi validada olhando a **SERP real** (o formato que o buscador já premia bate com o formato da LP).
- [ ] As **keywords secundárias / variações / entidades** do tópico estão mapeadas e cobertas de forma natural (sem stuffing).
- [ ] **Anti-canibalização confirmado:** nenhuma outra URL da casa — no mesmo domínio **ou em outro dos 4 domínios** — já disputa essa keyword/intenção. Se existe, foi consolidada, diferenciada ou resolvida com 301 **antes** de publicar.
- [ ] A intenção casa com o **domínio certo** (transacional/comercial → `.net`; informacional/institucional → `.org`/`.me`/`.com.br`) — ver seção 5.

**SHOULD**
- [ ] O ângulo da LP é distinto o suficiente pra não competir com conteúdo próprio vizinho (recurso vs comparativo vs caso).
- [ ] A keyword primária aparece de forma natural no title, no H1 e nos primeiros parágrafos — porque a página é sobre isso, não pra encaixar string.

---

## 2. On-page

> Fonte: `on-page.md`. Title/meta/headings/URL/mídia — o que o buscador e o usuário leem primeiro.

**MUST**
- [ ] **`<title>` único no site**, keyword-first, **~50–60 caracteres / ≤ ~600px** (o corte na SERP é por **pixel**, não por caractere — `on-page.md` §Title é a fonte única), verdadeiro (promete o que a página entrega).
- [ ] **`meta description`** própria, **~150–160 caracteres** (fonte única: `on-page.md` §Meta description), com **CTA** claro, descrevendo a página real (não genérica, não duplicada).
- [ ] **Exatamente UM `<h1>`**, refletindo a intenção da página.
- [ ] **Headings hierárquicos** (`h2`/`h3` sem pular nível) — a mesma hierarquia serve leitor de tela e crawler.
- [ ] **URL limpa e semântica**: slug legível, minúsculo, com a keyword, sem parâmetro de tracking na URL canônica, sem id solto evitável.
- [ ] **A LP responde à intenção acima da dobra** — a resposta/proposta de valor aparece sem precisar rolar; nada de enterrar a resposta sob hero decorativo.
- [ ] **Toda imagem com `alt`** descritivo e verdadeiro (vazio só em imagem puramente decorativa).
- [ ] **Âncoras internas descritivas** (nada de "clique aqui" / "saiba mais" solto) — o texto do link diz pra onde vai.

**SHOULD**
- [ ] Open Graph e Twitter Card próprios (`og:title/description/image/url/type`, `twitter:card`) com imagem 1200×630.
- [ ] Conteúdo em formato **extraível** onde couber (resposta direta, listas, tabelas) — ganha featured snippet e citação de IA (liga com seção 6).

---

## 3. Técnico

> Fonte: `tecnico.md` (índice; detalhe em `crawl-index.md`). Se a máquina não acessa/renderiza/entende, o resto não existe.

**MUST**
- [ ] **`rel=canonical` self-referente e absoluto** (uma versão: https, com/sem www decidido, sem params de tracking).
- [ ] Página **indexável de propósito**: sem `noindex` acidental, não bloqueada no `robots.txt`, conteúdo renderizado no servidor (existe sem depender de JS que o crawler não roda).
- [ ] Página **presente no `sitemap.xml`** (que é autogerado — ver `schematize-web`, não editado à mão) e o sitemap está registrado no `robots.txt`.
- [ ] **Sem redirect chain** pra chegar na URL final: o link publicado bate na URL 200 direto (nada de 301→301→200).
- [ ] **HTTPS** com certificado válido; sem mixed content.
- [ ] **Core Web Vitals no verde** (LCP / INP / CLS dentro do budget) — é fator de rank, implementação delega ao `schematize-web`, mas o resultado é exigido aqui.
- [ ] **Mobile ok**: usável e legível no celular (mobile-first), sem overflow horizontal, toque confortável.

**SHOULD**
- [ ] `lastmod` correto no sitemap pra esta URL.
- [ ] Recebe **link interno de página já indexada** (não nasce órfã — liga com seção 7).
- [ ] Assets otimizados (imagem no formato/dimensão certos) — o hero bonito não estoura o LCP.

---

## 4. Dados estruturados

> Fonte: `dados-estruturados.md`. JSON-LD válido e verdadeiro — nunca marca o que a página não mostra.

**MUST**
- [ ] **JSON-LD do tipo certo** pra natureza da LP: `SoftwareApplication` (produto schematize / CLI), `Course` (educe / cursos), `Article`/`BlogPosting` (conteúdo), `Organization`/`WebSite` (institucional). Um bloco por tipo.
- [ ] O JSON-LD **reflete o conteúdo visível** da página (marcar rich result que a página não exibe é spam → penalização manual).
- [ ] **Válido no Rich Results Test / schema validator** — passou sem erro antes de publicar.
- [ ] Campos de E-E-A-T presentes quando o tipo pede: `author`, `datePublished`/`dateModified`, `provider`, `offers`, conforme o caso.

**SHOULD**
- [ ] `BreadcrumbList` quando há navegação hierárquica (com breadcrumb visual coerente).
- [ ] Bloco de **Q&A** e/ou **passo a passo** quando o conteúdo genuinamente tem — pelo usuário e pela **citação por IA**, não pelo rich result: `FAQPage` e `HowTo` estão **mortos** na busca (✔ 2026-08-21, ver `dados-estruturados.md`).
- [ ] `inLanguage` e `og:locale` coerentes com o `<html lang>` da página.

---

## 5. Internacional / multi-domínio

> Fonte: `internacional-multidominio.md`. Os 4 domínios rankeiam juntos, sem canibalizar, sem canonical cruzado.

**MUST**
- [ ] A LP está no **domínio certo pro propósito**: `.net` (comercial/produto/cursos→educe, onde mora a conversão), `.org` (open-source/pesquisa), `.me` (marca/global, alta autoridade), `.com.br` (BR/pt-BR).
- [ ] **Self-canonical** — a canônica aponta pra própria URL. **NUNCA canonical cruzado** entre `.net`/`.org`/`.me`/`.com.br` (canonicalizar `.me`→`.net` jogaria fora a autoridade do `.me`).
- [ ] **`hreflang` SÓ se esta LP for tradução do MESMO conteúdo** noutra URL. Se for conteúdo distinto por domínio (não tradução), **não** tem hreflang — são páginas independentes conectadas por link, não por hreflang.
- [ ] Se tem `hreflang`: é **recíproco e completo** (cada URL lista todas as alternativas inclusive a si + `x-default`), e nenhuma alternativa aponta pra URL `noindex`/404.
- [ ] **Links de conversão apontam pro `.net`** — os "links que importam" (CTA de assinar/instalar/contratar) levam ao domínio comercial, independente de onde a LP mora.

**SHOULD**
- [ ] Conteúdo genuinamente distinto por domínio (não o mesmo HTML servido em duas propriedades — isso é duplicação).
- [ ] `<html lang>` e formatação (`Intl`: data/número/moeda) corretos pro locale da LP.

---

## 6. AIO / descoberta por IA

> Fonte: `aio-llmo-geo.md`. Ser a fonte que a IA cita — a 5ª etapa do funil (CITA).

**MUST**
- [ ] **Parágrafo-resposta extraível** no topo: a proposta/pergunta central respondida em 1–2 frases antes do aprofundamento — é o que vira trecho citado por AI Overview / ChatGPT / Perplexity.
- [ ] **Entidade clara** com `sameAs` no JSON-LD (`Organization`/`Person`) apontando pros perfis canônicos da casa — pra IA atribuir corretamente.
- [ ] *(SHOULD)* **`llms.txt` atualizado** contemplando esta LP quando ela é conteúdo relevante pra descoberta por IA — **não bloqueia a publicação** (`aio-llmo-geo.md`: nenhum crawler grande adotou a convenção).

**SHOULD**
- [ ] Fatos verificáveis, datados e com fonte (o que a IA precisa pra citar com segurança).
- [ ] Definições limpas, listas e tabelas onde o conteúdo pede (formato que a IA extrai).

---

## 7. Autoridade / E-E-A-T

> Fonte: `autoridade-eeat.md`. Por que confiar nesta fonte.

**MUST**
- [ ] **Autoria identificada quando aplicável** (conteúdo que aconselha / YMYL): `author` com identidade real e credencial, data verdadeira. Conteúdo que aconselha anônimo e sem data não publica.
- [ ] A LP recebe **link interno de página(s) forte(s)** da casa (não nasce isolada da autoridade já construída).

**SHOULD**
- [ ] **Experience de primeira mão** explícita quando cabe (o que a casa realmente usa/construiu — ex.: o `schematize` no dia a dia): dado próprio, print, caso real.
- [ ] Afirmação factual com fonte citada (sustenta Trust e habilita citação por IA).
- [ ] Plano de digital PR / menções pra LP que precisa de autoridade externa pra rankear (não bloqueia a publicação, mas fica registrado).

---

## 8. Medição

> Fonte: `medicao.md`. Sem baseline, é achismo — e achismo em SEO custa meses.

**MUST**
- [ ] A URL está sob a **propriedade correta do Google Search Console** (a do domínio onde a LP mora).
- [ ] **Baseline registrado** antes/na publicação (impressões/cliques/posição da query-alvo, ou marco "página nova a partir de X") — no archive de medição.
- [ ] **Evento de conversão configurado** e disparando no analytics (a ação de negócio da LP — assinar/instalar/contratar/lead), com o funil terminando em `.net` quando for conversão comercial.

**SHOULD**
- [ ] Rank tracking da keyword primária ligado pra acompanhar o "depois".
- [ ] Data de revisão agendada pra reavaliar a LP contra o baseline (SEO é processo contínuo, não config única).

---

## Fecho — o veredito do gate

Percorreu tudo? Então:

- [ ] **Todos os MUST das 8 seções estão marcados** (ou N/A justificado). Qualquer MUST em aberto = **a LP NÃO publica**.
- [ ] Os SHOULD abertos têm justificativa registrada no PR/archive.
- [ ] O archive de chat/task da publicação foi gerado (§28 do processo da casa) com o baseline de medição junto.

> Este gate existe pra proteger o ativo mais caro da casa: domínios com autoridade (`.me`, `.com.br`) levam anos pra construir e um deslize de SEO — canibalização indexada, canonical cruzado, thin content no ar — pra queimar. Marcar os itens não é burocracia: é a diferença entre uma LP que rankeia e é citada, e uma que dilui o que já funciona. Verde de build não é verde de SEO — o verde de SEO é este checklist inteiro fechado.
