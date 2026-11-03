# Filosofia e Anti-Padrões de SEO (Macaquices)

> **CITE ESTES ITENS PELO TÍTULO, NUNCA PELO NÚMERO.** A numeração é **local desta skill** e
> **diverge entre as irmãs**: o mesmo `§37 item 45` é *"authz hand-rolled"* aqui, *"bloquear o
> scheduler da BEAM"* na `schematize-elixir` e *"dois serviços no mesmo user Linux"* na
> `schematize-ruby`; o item 49 é *"efeito externo real fora de prd"* na base, não existe em três
> skills e é *"ReleaseFast sem profiling"* na `schematize-zig`. Os máximos vão de 46 a 53. Um
> ponteiro `§37 item N` cruzando skills aponta para outra coisa — e um dentro da própria skill
> apodrece assim que alguém insere um item no meio (foi o que aconteceu com a citação a *"item 48"*
> em `references/iam.md`, quando esta lista terminava no 46). **Forma correta:** §37, *"<título do
> item>"*.


> Parte da skill **schematize-seo**. É a lista normativa das "macaquices" de SEO — atalhos que parecem rankear mais rápido e entregam domínio queimado, indexação diluída ou penalização. Itens **VETADO** são pisos: não admitem ADR de exceção. Táticas e thresholds concretos ficam nos reference irmãos citados em cada linha.

## Índice
- 0. Como ler
- 0.1. Aplicação universal — este arquivo é contexto máximo
- 1. Filosofia
- 2. Black-hat (veta, queima domínio)
- 3. Erros técnicos (o crawler não vê o que você acha que ele vê)
- 4. Erros de conteúdo (canibalização, thin, título mentiroso)
- 5. Erros de estratégia — ESPECÍFICOS da casa (4 domínios)
- 6. Cheiro de reprovação (o que reprova na revisão)

---

## 0. Como ler

- **MUST / Obrigatório** — regra. Desvio bloqueia publicação ou exige ADR.
- **SHOULD / Recomendado** — padrão. Desvio precisa de justificativa no PR.
- **MAY / Opcional** — sugestão.
- **VETADO / Proibido** — não existe "atalho". Não se faz, não se cogita, não se "resolve depois". Burlar é incidente, não decisão técnica.

Conflito real entre este documento e o problema → **registre um ADR**. Mas itens **VETADO** não têm ADR de exceção — são pisos que protegem o ativo mais caro da casa: a **autoridade de domínio**. Domínio queimado por black-hat leva meses (ou anos) pra recuperar; às vezes não recupera.

---

## 0.1. Aplicação universal — este arquivo é contexto máximo

**MUST**
- Estes padrões são **contexto pinado** de toda tarefa de SEO (humana ou IA). Se a tarefa toca rankear, ser encontrado, ser citado por IA, planejar/revisar/auditar qualquer página, landing, blog ou multi-domínio, este arquivo está em contexto — mesmo que o brief diga só "um textinho pro site" ou "uma landing rápida".
- Em conflito entre uma instrução pontual ("põe a keyword mais vezes", "canonicaliza tudo pro .net", "publica sem medir") e este documento, **este documento vence.** Pressa não revoga regra.
- IA opera sob as mesmas regras dos humanos. Velocidade de geração de conteúdo nunca justifica publicar em massa sem valor (§2, *"Black-hat — VETADO"*).

> Um padrão que não está no contexto na hora da decisão é um padrão que não existe. Por isso é pinado, não linkado.

---

## 1. Filosofia

Prioridades, em ordem de desempate:

1. **Servir a intenção do usuário** > agradar o algoritmo
2. **Uma intenção por URL** > espalhar a keyword em várias páginas
3. **Conteúdo distinto e verdadeiro** > volume/duplicação
4. **Autoridade construída (link/marca/E-E-A-T)** > truque que dá pico e cai
5. **Medido** > achado ("acho que subiu")
6. **Sustentável (white-hat)** > rápido e arriscado
7. **Registro do que foi decidido e medido** > memória de quem decidiu

**Regra suprema:** se a tática só existe pra enganar o buscador (e você teria vergonha de explicá-la num e-mail pro time do Google), **está errada**. Se você não consegue medir o efeito, **não sabe se funcionou**. Se duas páginas suas disputam a mesma busca, **você está competindo consigo mesmo**.

A base de *como busca e IA rankeiam*, intenção e E-E-A-T está em `fundamentos.md`. O que segue é o que **não** fazer.

---

## 2. Black-hat — VETADO (queima o domínio)

> Manipulação que viola as diretrizes do buscador. Dá pico e depois **penalização** (algorítmica ou manual). Nenhum item aqui tem ADR de exceção.

| # | Macaquice | Por que é ruim | O que fazer no lugar |
|---|---|---|---|
| 1 | **Cloaking** — servir HTML diferente pro crawler e pro usuário (por User-Agent/IP) | Violação direta; quando pega, é penalização manual e desindexação | **Mesmo conteúdo pra todos.** SSR/SSG do conteúdo real (delega implementação ao `schematize-web`) |
| 2 | **Doorway pages** — enxame de páginas quase iguais (uma por cidade/keyword) só pra funilar pro mesmo destino | Thin em escala, canibaliza entre si, dispara filtro de spam | Uma página forte por intenção real; variação regional só com **conteúdo genuinamente distinto** (§4) |
| 3 | **Texto oculto** — keyword em `display:none`, cor da fonte = cor do fundo, `font-size:0`, fora da viewport | O buscador detecta; sinaliza intenção de enganar | Conteúdo é **visível**. O que o usuário não vê, não conta a favor — conta contra |
| 4 | **Keyword stuffing** — repetir a keyword até o texto virar lista, ou lotar `alt`/meta de termos | Prosa anti-humana derruba engajamento e não sobe rank (Google usa semântica, não contagem) | Escrever pra humano; a keyword aparece **naturalmente** + termos correlatos/entidades (`on-page.md`, `keywords-conteudo.md`) |
| 5 | **PBN** (rede privada de blogs) e **link comprado/trocado dissimulado** sem `rel="sponsored"`/`nofollow` | Esquema de link é violação; um deslink em massa derruba tudo que dependia dele | Link **ganho**: conteúdo linkável, digital PR, parceria real. Link pago/afiliado leva `rel="sponsored"` (`autoridade-eeat.md`) |
| 6 | **Troca recíproca em escala** ("linko você, você me linka") como esquema | Padrão artificial, desvalorizado ou penalizado | Link editorial por mérito; troca pontual e relevante é ok, esquema não |
| 7 | **Conteúdo de IA em massa sem valor** — publicar centenas de páginas geradas, sem revisão, edição ou expertise | Cai no *scaled content abuse*; thin/duplicado em volume; some numa atualização de core | IA como **rascunho**, sempre com revisão humana, fato verificado, expertise e valor único (`keywords-conteudo.md`) |
| 8 | **Negative SEO** — atacar concorrente (spam de link tóxico, scraping, spam de report) | Antiético e ilegal; fora dos valores da casa; risco jurídico | **Não se faz.** Defesa própria: monitorar perfil de link e usar disavow só quando necessário (`autoridade-eeat.md`) |
| 9 | **Marcar rich result que a página não mostra** — `Review`/`FAQ`/`Product` no JSON-LD sem o conteúdo visível correspondente | Violação de structured data → penalização manual e perda de **todos** os rich results do site | JSON-LD **reflete o visível** e passa no validador (`dados-estruturados.md`) |

---

## 3. Erros técnicos — o crawler não vê o que você acha que ele vê

> Não é má-fé; é descuido que apaga a página do índice ou desperdiça crawl budget. Detalhe e correção em `tecnico.md`.

| # | Macaquice | Por que é ruim | O que fazer no lugar |
|---|---|---|---|
| 10 | **`noindex` acidental** — tag/header ficou de staging, ou template global marcou tudo | A página some do índice em silêncio; ninguém percebe até o tráfego cair | `noindex` **só** onde é intencional (staging, busca interna, área privada). Auditar antes de subir (`checklist-lp.md`) |
| 11 | **`Disallow` bloqueando o que devia indexar** — `robots.txt` fechando `/`, `/blog`, ou o CSS/JS que renderiza | `robots` bloqueia **rastreio**, não indexação; recurso essencial bloqueado quebra a renderização vista pelo crawler | `robots.txt` libera o que deve rankear + o CSS/JS de render; fecha só o que não deve ser rastreado. `noindex` (não `Disallow`) pra tirar do índice |
| 12 | **Cadeia/loop de redirect** — A→B→C→D, ou 301 que volta pra origem | Dilui sinal a cada salto, gasta crawl budget, e loop = página inacessível | Redirect em **um salto** direto pro destino final; sem loop; 301 pra permanente, 302 só pra temporário |
| 13 | **Soft-404** — página "não encontrado" que responde `200 OK`, ou vazia que finge existir | O buscador indexa lixo e desconfia da qualidade do site | Inexistente responde **404/410**; movido responde **301**. Status HTTP diz a verdade |
| 14 | **Canonical errado** — canônica apontando pra outra página, pra versão `noindex`, ou relativa/quebrada | Consolida sinal na URL errada ou joga a página pra fora do índice | **Self-canonical** absoluto por padrão; canônica só aponta pra outra URL quando é de fato a mesma intenção (§5.1) |
| 15 | **hreflang não-recíproco** ou sem `x-default` — A aponta pra B, B não aponta pra A; ou lista URL `noindex`/404 | hreflang quebrado é **ignorado inteiro** pelo Google; erro internacional nº 1 | Conjunto **recíproco e completo**, cada URL lista todas (inclusive a si) + `x-default`, todas `200`/indexáveis (`internacional-multidominio.md`) |
| 16 | **Sitemap com URL 404/`noindex`/redirect/não-canônica** — sitemap desatualizado ou mantido à mão | Sinaliza descuido, gasta crawl budget, contradiz o canonical | Sitemap **autogerado** da fonte da verdade, só com URLs `200`, indexáveis e canônicas; regenera a cada build (`tecnico.md`, delega geração ao `schematize-web`) |
| 17 | **Conteúdo só-em-JS que o crawler não executa** — texto/link que só aparece após fetch no cliente | O buscador (e a IA) podem não ver; a página parece vazia | Conteúdo crítico no **HTML do servidor** (SSR/SSG); JS enriquece, não é pré-requisito pra ver o conteúdo |
| 18 | **CWV no vermelho e a11y ignorada** tratados como "não é SEO" | Core Web Vitals e acessibilidade são fator de rank e de extração por IA | Resultado no verde é **exigência** de SEO; a implementação delega ao `schematize-web`, mas o SEO cobra o número |

---

## 4. Erros de conteúdo — canibalização, thin, título mentiroso

| # | Macaquice | Por que é ruim | O que fazer no lugar |
|---|---|---|---|
| 19 | **Canibalização** — duas (ou mais) URLs disputando a **mesma intenção/keyword** | Você compete consigo mesmo: o Google não sabe qual rankear, os sinais se dividem, nenhuma sobe | **Uma intenção por URL.** Consolidar (301 a mais fraca na forte), diferenciar a intenção, ou reestruturar o cluster (`keywords-conteudo.md`) |
| 20 | **Thin / duplicado** — página sem valor único, ou o mesmo texto em várias URLs (incl. variação por parâmetro) | Nada pra rankear; conteúdo duplicado dilui e desperdiça crawl | Conteúdo **substancial e único** por página; duplicata técnica resolve com canonical (§5.1); sem valor, não publica |
| 21 | **HOME duplicada nos 4 domínios** — mesma landing colada em `.net`/`.org`/`.me`/`.com.br` | Quatro propriedades com conteúdo idêntico = duplicação entre domínios da casa; nenhuma se diferencia, competem entre si | Cada domínio tem **home e proposta distintas** conforme seu papel (§5); conectam por link, não por cópia (`internacional-multidominio.md`) |
| 22 | **Title/meta duplicados ou genéricos** — todo o site com o mesmo `<title>`, ou "Home \| Empresa" | Buscador reescreve o snippet (ou some do topo); usuário não clica | `<title>` e `description` **únicos, descritivos e verdadeiros** por página, com a intenção da página (`on-page.md`, `checklist-lp.md`) |
| 23 | **H1 múltiplo/enganoso** — vários H1, ou H1 que promete o que a página não entrega | Hierarquia confusa pro crawler e pro leitor de tela; título mentiroso gera *pogo-stick* (usuário volta pro Google) e derruba o rank | **Um H1** por página, refletindo a intenção real; hierarquia H2/H3 coerente (`on-page.md`) |
| 24 | **Texto keyword-first anti-humano** — escrever pro robô, não pra pessoa (frase torta pra encaixar a keyword exata) | Engajamento cai, IA não cita texto ruim, e o Google entende semântica — não precisa da keyword crua | Escrever pra **pessoa** primeiro; keyword e entidades entram naturalmente; blocos extraíveis/citáveis pra IA (`aio-llmo-geo.md`) |
| 25 | **Ignorar a intenção** — página informacional otimizada pra keyword transacional (ou vice-versa) | Casa errado com o que o usuário quer; alta rejeição, sem conversão | Mapear a **intenção dominante** da keyword e servir o formato certo (guia, comparativo, página de produto) — `keywords-conteudo.md` |

---

## 5. Erros de estratégia — ESPECÍFICOS da casa (4 domínios)

> A casa opera **quatro domínios** com papéis distintos. Todos devem rankear, **sem canibalizar** e **sem canonical cruzado**. Estratégia completa em `internacional-multidominio.md`.

**Papel de cada domínio (âncora da estratégia):**

| Domínio | Papel | Intenção que serve |
|---|---|---|
| **.net** | Comercial — **âncora de conversão** | Transacional/produto; recebe os "links que importam" |
| **.org** | Open-source / pesquisa | Informacional técnico, docs, comunidade |
| **.me** | Marca — **alta autoridade** | Institucional/identidade, topo de funil, brand |
| **.com.br** | Brasil | Mercado BR (pt-BR), local, conversão regional |

**Regra de ouro:** cada domínio é **self-canonical**, tem **conteúdo distinto** e se conectam por **links** (não por canonical, não por cópia).

### 5.1 Anti-padrões de estratégia

| # | Macaquice | Por que é ruim | O que fazer no lugar |
|---|---|---|---|
| 26 | **Canonicalizar `.me`/`.com.br` → `.net` e perder autoridade** — apontar `rel=canonical` de um domínio da casa pra outro pra "consolidar" | **VETADO.** São propriedades distintas; canonical cruzado joga fora a autoridade do domínio-origem (o `.me` é ativo caro) e some do índice sob o `.net`. Não consolida — **destrói** | Cada domínio **self-canonical**. Diferenciar por conteúdo/intenção; conectar por link (os "que importam" apontam pro `.net`) — nunca por canonical (`internacional-multidominio.md`, piso §4 da SKILL) |
| 27 | **`nofollow` entre os próprios domínios da casa** — marcar link interno da casa (`.me`→`.net`) como `nofollow` | Você bloqueia o fluxo de autoridade **de propósito** entre ativos que são seus; desperdiça o link mais valioso que você controla | Link entre domínios da casa é **follow**, contextual e recíproco onde faz sentido; `nofollow`/`sponsored` só pra link pago/UGC/externo não-endossado (`autoridade-eeat.md`) |
| 28 | **Home/conteúdo duplicado entre domínios** (ver §21) tratado como "é tudo a mesma empresa" | Duplicação entre domínios; competem pela mesma busca; nenhum se diferencia | Conteúdo **distinto por papel** (tabela acima); a mesma oferta se expressa diferente em cada domínio |
| 29 | **Não medir nada** — publicar/otimizar e nunca abrir GSC/analytics | Sem baseline você não sabe se subiu, caiu ou por quê; achismo custa meses | **Baseline antes, medição depois** de toda mudança relevante (GSC, analytics, rank, log) — `medicao.md`, piso §10 da SKILL |
| 30 | **Caçar volume ignorando intenção** — perseguir a keyword de maior volume sem checar se converte ou se casa com a página | Tráfego que não converte nem engaja; sinal ruim; esforço desperdiçado | Priorizar por **intenção × valor de negócio × dificuldade**, não só volume; mapear intenção por keyword (`keywords-conteudo.md`) |
| 31 | **Ignorar IA / AIO** — otimizar só pra dez links azuis num mundo de AI Overviews, ChatGPT e Perplexity | Perde a citação por IA (cada vez mais o ponto de descoberta); conteúdo não-extraível some da resposta | Otimizar pra **ser citável**: blocos extraíveis, dados estruturados, entidade/E-E-A-T, `llms.txt` (`aio-llmo-geo.md`) |
| 32 | **Redirecionar os "links que importam" pro domínio errado** — ou não ter estratégia de qual domínio recebe o link de autoridade | Autoridade externa se espalha sem concentrar onde converte; o `.net` (âncora) fica fraco | Estratégia explícita: os backlinks de conversão apontam/consolidam no **.net**; institucional constrói marca no **.me** (`internacional-multidominio.md`) |

---

## 6. Cheiro de reprovação (o que reprova na revisão)

> **Nota de leitura:** as remissões abaixo são para o **item numerado da tabela** deste arquivo
> ("item 26"), **não** para uma seção. Elas usavam `§26`, e `§N` no catálogo significa **seção** —
> o mesmo símbolo com dois sentidos no mesmo arquivo é o que faz alguém procurar a "§26" e não
> achar. (A regra `item-por-numero` do lint do catálogo existe por causa desta classe.)

> Rode isto em qualquer página/PR/plano de SEO. Um item marcado = **para e faz certo** antes de publicar. Os itens de black-hat (item 2) e canonical cruzado (item 26) são **veto absoluto**: não passam com ADR.

- [ ] Alguma tática só existe pra enganar o buscador (cloaking, texto oculto, doorway, stuffing, PBN, link comprado dissimulado, IA em massa sem valor)? → item 2, **veto**
- [ ] JSON-LD marca rich result que **não** está visível na página? → item 2 (*"Black-hat"*) e `dados-estruturados.md`, **veto**
- [ ] Existe `rel=canonical` cruzando domínios da casa (`.me`/`.com.br`/`.org` → `.net`)? → item 26, **veto**
- [ ] Link entre domínios da casa está com `nofollow`? → item 27
- [ ] Duas URLs disputam a **mesma intenção/keyword** (canibalização)? → item 19
- [ ] Home ou conteúdo **duplicado** entre os 4 domínios (ou thin/duplicado interno)? → item 21, item 20, item 28
- [ ] `<title>`, `description` ou `H1` duplicados, genéricos ou mentirosos? Mais de um H1? → `on-page.md` item 1, item 2 e item 3
- [ ] Texto escrito pro robô (keyword-first, anti-humano) em vez de pra pessoa? → item 24
- [ ] Página casa com a **intenção** certa da keyword? Priorizou intenção/valor, não só volume? → item 25, item 30
- [ ] Algum `noindex`/`Disallow` acidental tirando do índice o que deveria rankear? → item 10, item 11
- [ ] Cadeia/loop de redirect, soft-404, ou status HTTP mentindo? → item 12, item 13
- [ ] Canonical aponta pra si (self-canonical) e não pra página errada/`noindex`? → item 14
- [ ] hreflang **recíproco e completo** com `x-default`, todas as URLs `200`/indexáveis? → item 15
- [ ] Sitemap **autogerado**, só com URLs `200`/indexáveis/canônicas? → item 16
- [ ] Conteúdo crítico está no **HTML do servidor** (não só-em-JS)? → item 17
- [ ] CWV no verde e a11y AA (exigência de SEO, delega implementação ao `schematize-web`)? → item 18
- [ ] Conteúdo é **extraível/citável por IA** (blocos, dados estruturados, entidade, `llms.txt`)? → item 31
- [ ] Há **baseline** (GSC/analytics) antes e plano de medir depois? → item 29
- [ ] Cada domínio da casa é **self-canonical**, com conteúdo **distinto** por papel, conectado por **link**? → item 5

> Regra de bolso: se a justificativa começa com "põe a keyword mais vezes", "canonicaliza tudo pro .net", "publica que depois eu meço", "gera cem páginas com IA" ou "é mais rápido assim" — **provavelmente é uma macaquice desta lista. Para e faz certo.** Domínio com autoridade é ativo caro; não se queima por atalho.
