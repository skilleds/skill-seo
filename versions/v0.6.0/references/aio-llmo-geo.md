# Descoberta por IA — AIO, LLMO, GEO: ser citado por máquina

> Parte da skill **schematize-seo**. Esta é a **fonte de disciplina** da casa para
> descoberta por IA. O SEO clássico (`tecnico.md`, `on-page.md`) faz o site ser
> **achado por buscadores**; esta reference faz o conteúdo ser **lido, entendido e
> citado por answer engines** — AI Overviews do Google, ChatGPT, Perplexity, Claude
> e qualquer agente que consome a web. A **implementação** no frontend (SSR/SSG,
> `metadata`, JSON-LD, sitemap, robots) delega ao `schematize-web` (`aio-llmo-geo.md`
> de lá); a **estratégia, os pisos e a decisão** ficam aqui.

Irmãos que esta reference cita e não repete: dados estruturados em
`dados-estruturados.md`; autoridade/autoria/proveniência em `autoridade-eeat.md`;
como medir presença em IA em `medicao.md`; multi-domínio e consistência de marca em
`internacional-multidominio.md`; anti-padrões (cloaking, texto oculto) em
`anti-padroes.md`.

**Índice:** cenário · AIO/LLMO/GEO · como ser citado · estrutura legível por máquina
· `llms.txt` · política de crawler · entity SEO · medição · aplicação à casa ·
checklist.

---

## O cenário e por que muda o SEO

O usuário deixou de só **clicar em dez links azuis**. Ele lê uma **resposta
sintetizada** — AI Overview no topo do Google, ou a saída de um answer engine
(ChatGPT, Perplexity, Claude). A resposta é montada a partir de **várias fontes**,
com **citação** de algumas. O jogo mudou de "rankear a página" para **"ser a fonte
que a IA extrai e credita"**.

Consequências que a casa trata como fato, não opinião:

| Antes (SEO de link) | Agora (descoberta por IA) |
|---|---|
| Rankear a **página** | Ser citado por **afirmação** |
| Clique é o resultado | Menção/citação pode ser o resultado (zero-click) |
| Título + snippet vendem o clique | O **parágrafo-resposta** vira o trecho sintetizado |
| Keyword na intenção | **Cobertura da pergunta** de ponta a ponta |
| Autoridade = backlinks | Autoridade = **ser fonte primária reconhecível** |

**Piso:** o que a IA lê é **o HTML servido**. Crawler de IA que não executa JS só
vê o que veio no HTML inicial. Conteúdo que só aparece após hidratação é **invisível**
para boa parte deles — daí SSR/SSG ser obrigatório (delega ao `schematize-web`).

---

## AIO, LLMO, GEO — o que é cada

As três siglas circulam como sinônimo no mercado; a casa as trata com escopo
distinto para não misturar tática.

| Sigla | Nome | O que otimiza | Alvo |
|---|---|---|---|
| **AIO** | AI Optimization / AI Overviews | Aparecer e ser citado nas **respostas generativas do Google** — **AI Overviews** e o **AI Mode** (2025). *("SGE" era o nome do experimento e está morto; usar o nome antigo faz o texto envelhecer sozinho.)* AI Overviews) | Superfície do próprio buscador |
| **LLMO** | LLM Optimization | Ser **lido, entendido e reutilizado** por LLMs (assistentes e agentes) | O modelo e sua leitura da página |
| **GEO** | Generative Engine Optimization | Otimizar para **answer engines** que sintetizam e citam (Perplexity, ChatGPT search, etc.) | O motor de resposta |

Não são disciplinas concorrentes: são a mesma higiene vista de três ângulos —
**conteúdo extraível + estrutura legível por máquina + autoridade de fonte**. A casa
executa as três com o mesmo conjunto de regras abaixo. Onde precisar de um nome
único internamente, use **descoberta por IA**.

---

## Como ser citado por IA

A IA cita o que consegue **recortar sem ambiguidade** e **atribuir a uma fonte
confiável**. Escreva para isso.

### Conteúdo extraível e citável

**MUST**
- **Resposta direta no topo.** Cada página/seção responde a **uma** pergunta, e a
  resposta objetiva vem **no primeiro parágrafo** — não enterrada após 800 palavras
  de introdução. É o *parágrafo-resposta* que a IA sintetiza.
- **Padrão pergunta→resposta.** A pergunta como heading (`<h2>`/`<h3>`), a resposta
  em 2–4 frases logo abaixo, detalhe depois. Casa com o **bloco de Q&A visível** — não com `FAQPage`, que morreu como rich result mas cujo *formato de conteúdo* continua sendo o que a IA cita (ver
  `dados-estruturados.md`).
- **Fatos auto-contidos.** Datas **absolutas** (nunca "ano passado"), unidades
  explícitas, nome completo na primeira menção. A IA recorta um parágrafo **sem o
  resto da página** — o trecho tem que se sustentar sozinho.
- **Dados e estatísticas COM fonte.** Todo número factual traz origem e data,
  linkada quando externa. Afirmação numérica sem proveniência não é citável (a IA
  desconfia) e não é honesta (ver `autoridade-eeat.md`).
- **Listas e tabelas para dado estruturado.** Passos, comparações, specs → lista ou
  tabela. A IA extrai lista/tabela muito melhor que prosa densa.

**SHOULD**
- **TL;DR / resumo no topo** em conteúdo longo — costuma virar o trecho citado.
- **Glossário e definições explícitas** ("X é ..."): termo definido vira resposta
  direta a uma pergunta de definição.
- **Âncoras por seção** (`id` em headings) para "deep link" na afirmação exata.
- **Cobrir a pergunta inteira** (o "e se", o "como", o "quanto custa") — a IA prefere
  a fonte que fecha o tópico.

**VETADO**
- Texto-isca para IA **escondido** (oculto por CSS, branco no branco, `aria-hidden`
  cheio de keyword, prompt injection embutido no conteúdo). É cloaking/spam, é
  desonesto e queima o domínio. **O que a IA lê é o que o usuário vê.** Ver
  `anti-padroes.md`.
- Prometer no conteúdo o que a página não entrega. Pogo-stick de IA (a resposta não
  bate com a página) derruba a fonte da próxima síntese.

---

## Estrutura legível por máquina

Dar à máquina a versão estruturada do que o humano lê. Tudo reflete o conteúdo
**visível** — marcar o que não está na página é spam (ver `dados-estruturados.md`).

**MUST**
- **Hierarquia de headings real:** um `<h1>`, `<h2>/<h3>` que são perguntas ou
  tópicos claros. A IA usa a árvore de headings para **segmentar** o documento.
- **Semântica HTML5:** `<article>`, `<main>`, `<nav>`, `<time datetime>` para datas.
  Dá significado de máquina sem custo.
- **JSON-LD schema.org** nos tipos aplicáveis — a forma preferida pelo Google e
  consumível por LLM. Detalhe, catálogo e validação em `dados-estruturados.md`.
- **Metadados completos** (`<title>`, description, canonical, Open Graph, Twitter
  Card) — é o que preview e muitos agentes leem primeiro. Detalhe em `on-page.md`.

**SHOULD**
- **Feed** (RSS/Atom ou JSON Feed) quando há conteúdo serial (blog/pesquisa) —
  canal estável e barato para máquinas e agentes acompanharem novidades.
- **Versão limpa em texto/Markdown** da mesma URL quando viável (via content
  negotiation ou `.md`), reduzindo ruído de layout para o agente.

---

## `llms.txt` — o que é, formato, hospedagem

> **Força: SHOULD, não MUST — e a razão importa.** ✔ **Verificado em 2026-08-21:** o `llms.txt` é
> uma **proposta de convenção** que **nenhum crawler ou answer engine grande adotou** como fonte.
> O benefício real hoje é **interno e colateral** (obriga a curar o que importa, e serve a quem
> **você** aponta para ele), não "o modelo vai ler isto". Tratá-lo como **MUST com gate de
> publicação** — como esta skill fazia — é gastar crédito de piso numa aposta: quando o gate trava
> um release por causa de um arquivo que ninguém consome, o time aprende a **desligar gate**, e o
> dano se paga nos gates que importam.
>
> A `schematize-web` já o tratava como SHOULD; agora **as duas dizem a mesma coisa** (era uma das
> divergências da Classe F da vistoria). O que **é** MUST continua sendo o que tem consumidor
> comprovado: **dados estruturados válidos**, **conteúdo citável** (resposta direta em 2–4 frases
> perto do topo), **entidade** e **E-E-A-T**.

Convenção emergente, barata e alinhada à casa: um índice curado **para LLM**,
análogo ao `sitemap.xml` para buscador. Não substitui sitemap nem robots — soma.

**O que é.** Um arquivo **Markdown** que descreve a propriedade e **aponta** para as
páginas/curadorias mais importantes, com uma linha de contexto cada. Serve para o
LLM entender o site rápido e ir direto ao conteúdo que importa.

**Onde hospedar.** Na **raiz de cada domínio**: `https://<domínio>/llms.txt`.
Opcionalmente `llms-full.txt` com o corpo completo concatenado, quando o conteúdo
couber e fizer sentido servir inteiro.

**Formato** (estável e mínimo):

```markdown
# schematize
> CLI open-source de scaffolding/geração guiada por skills normativas.

## Docs
- [Guia de início](https://schematize.org/docs/start): instalar e primeiro projeto
- [Referência de skills](https://schematize.org/docs/skills): catálogo normativo

## Pesquisa
- [Papers e benchmarks](https://schematize.org/research): fonte técnica primária
```

**MUST**
- **SHOULD** — `llms.txt` **gerado/curado junto com o conteúdo** quando existir; nunca à mão e desatualizado. *Não trava publicação* (ver a nota de força no início da seção).
  Mesma disciplina do sitemap (delega ao `schematize-web`).
- **Um por domínio**, coerente com o conteúdo daquele domínio (o `.org` aponta para
  pesquisa; o `.net` para produto/comercial — ver `internacional-multidominio.md`).

**VETADO**
- `llms.txt` que promete conteúdo **divergente** do que a página entrega — é
  cloaking com outro nome.

---

## Política de crawler de IA no robots

Decisão **consciente e registrada em ADR**, não default no susto. Bots de IA têm
user-agents próprios, e treinamento é diferente de indexação-de-resposta.

| User-agent | Operador | Função predominante |
|---|---|---|
| `GPTBot` | OpenAI | Coleta para treinamento |
| `OAI-SearchBot` | OpenAI | Indexação para ChatGPT search |
| `ChatGPT-User` | OpenAI | Fetch ao vivo por ação do usuário |
| `ClaudeBot` | Anthropic | Coleta para treinamento |
| `Claude-User` / `Claude-SearchBot` | Anthropic | Fetch/indexação de resposta |
| `PerplexityBot` | Perplexity | Indexação para respostas |
| `Google-Extended` | Google | Opt-out de uso em treino Gemini (**não** afeta busca) |

**Recomendação da casa: permitir por padrão para ganhar citação.** Bloquear crawler
de IA remove a chance de **ser a fonte citada** — que é exatamente o objetivo desta
reference. Só restrinja com motivo registrado (conteúdo proprietário, licenciamento,
jurídico). O trade-off:

| Permitir (default da casa) | Bloquear |
|---|---|
| Elegível a citação/menção em IA | Sai das respostas generativas |
| Marca aparece como fonte | Protege conteúdo de reuso/treino |
| Alcança tráfego de answer engine | Perde superfície nova de descoberta |

**MUST**
- Declarar a política em `robots.txt` (e/ou `X-Robots-Tag`), **por bot**, conforme a
  decisão de produto/jurídico registrada em ADR.
- **`robots.txt` não é controle de acesso.** Conteúdo que **não pode** ser lido por
  terceiro é protegido por **auth no servidor**, não por diretiva que o bot pode
  ignorar. Ver `tecnico.md`.
- Distinguir, na decisão, **treinamento** (`GPTBot`, `ClaudeBot`, `Google-Extended`)
  de **indexação-de-resposta** (os `*-SearchBot`/`*-User`): dá para optar por sair do
  treino e continuar elegível à citação, se essa for a política.

**SHOULD**
- Revisar a lista de user-agents periodicamente (mudam) e manter a política no
  `RUNBOOK`/ADR.

---

## Entity SEO / knowledge graph

Buscador e IA raciocinam sobre **entidades**, não só strings. A casa precisa ser uma
**entidade reconhecível** — o produto **schematize** e a **organização** por trás.

**MUST**
- **`Organization` em JSON-LD** no site institucional, com `name`, `logo`, `url` e
  **`sameAs`** apontando para os perfis oficiais (GitHub `schematizeme`, redes,
  Wikidata/Wikipedia quando existir). Detalhe do markup em `dados-estruturados.md`.
- **`SoftwareApplication`** (ou `SoftwareSourceCode`) para o **schematize** como
  produto citável: nome, categoria, `applicationCategory`, licença open-source,
  repositório. É assim que a IA reconhece o produto como **entidade nomeável**.
- **Consistência de marca cross-domain.** Mesmo nome, mesma descrição-núcleo, mesmos
  `sameAs` nos quatro domínios (`.net`, `.org`, `.me`, `.com.br`). Divergência
  fragmenta a entidade e enfraquece o reconhecimento. Ver
  `internacional-multidominio.md` (cada domínio é self-canonical; a entidade é uma
  só, ligada por `sameAs` e por links, nunca por canonical cruzado).

**SHOULD**
- **Wikidata/Wikipedia quando couber** (notabilidade real, sem auto-promoção que
  viole as regras de lá) — item no Wikidata é âncora forte de knowledge graph.
- **`sameAs` recíproco** onde possível (o perfil oficial referencia o site de volta).
- Autoria e proveniência consistentes reforçam a entidade — ver `autoridade-eeat.md`.

---

## Medir presença em IA

Não dá para otimizar o que não se mede. O funil ganhou uma etapa: crawl → index →
rank → **citação/menção em IA** → tráfego → conversão. Metodologia, ferramentas e
cadência ficam em `medicao.md`; aqui, o que rastrear:

| Sinal | Como observar |
|---|---|
| **Citações/menções** em answer engines | Consultas-alvo repetidas nos motores; a marca/URL aparece como fonte? |
| **Tráfego de referral de IA** | Segmentar analytics por origem (ChatGPT, Perplexity, etc.) |
| **Hits de crawler de IA** | Log do servidor por user-agent (`GPTBot`, `ClaudeBot`, `PerplexityBot`…) |
| **Presença em AI Overviews** | Monitorar as queries onde o Google mostra overview e se a casa é citada |
| **Consistência da entidade** | A IA descreve o **schematize** corretamente quando perguntada? |

**MUST** — registrar **baseline e depois** de qualquer mudança relevante (piso da
skill). Sem medição, é achismo. Detalhe em `medicao.md`.

---

## Aplicação à casa (schematize + `.org`)

A estratégia da casa para descoberta por IA é concreta:

- **`schematize` (CLI open-source) como entidade/produto citável.** Marcado como
  `SoftwareApplication`, com `sameAs` para o repo e perfis, descrição consistente
  cross-domain. Objetivo: quando a IA fala de scaffolding/geração guiada por skills,
  **cita o schematize pelo nome**.
- **`.org` como fonte técnica/pesquisa primária citável.** Conteúdo técnico e
  pesquisa (papers, benchmarks, guias normativos) publicados no `.org` são o **ativo
  de citação** — texto extraível, dados com fonte, autoria clara, `Article` +
  `Organization` marcados, `llms.txt` apontando para eles. É a superfície que a casa
  **quer** que a IA leia e credite.
- **`.net` (comercial), `.me` (marca), `.com.br` (BR)** cada um self-canonical, com
  a **mesma entidade** (`Organization`/`sameAs` consistentes) e crawler de IA
  **permitido por default** para maximizar citação. Os "links que importam" e a
  estratégia de conteúdo distinto por domínio estão em
  `internacional-multidominio.md`.

> Regra de bolso: **escreva para o humano, marque para a máquina, não minta para
> nenhum dos dois.** Conteúdo claro, no HTML servido, com fatos auto-contidos, dados
> com fonte e structured data fiel é o que o buscador rankeia, a IA cita e o usuário
> entende — os três ao mesmo tempo. Truque escondido para robô é o anti-padrão.

---

## Checklist — descoberta por IA (por propriedade/página)

- [ ] Conteúdo **renderizado no servidor** (SSR/SSG): `curl`/ver-código-fonte mostra o texto e o JSON-LD sem depender de JS.
- [ ] **Uma intenção por página/seção**, com **resposta direta no primeiro parágrafo** (parágrafo-resposta).
- [ ] **Fatos auto-contidos:** datas absolutas, unidades, nome completo na primeira menção — o trecho se sustenta recortado.
- [ ] **Todo dado/estatística com fonte** (origem + data, linkada quando externa).
- [ ] **Listas e tabelas** para passos/comparações/specs; **TL;DR** no conteúdo longo.
- [ ] **Hierarquia de headings real** (um `<h1>`; `<h2>/<h3>` como perguntas/tópicos) e **semântica HTML5**.
- [ ] **JSON-LD** aplicável presente e válido (ver `dados-estruturados.md`); reflete o conteúdo visível.
- [ ] **`Organization` + `sameAs`** no institucional; **`SoftwareApplication`** para o **schematize**.
- [ ] **Consistência de marca cross-domain** (nome/descrição/`sameAs` iguais nos 4 domínios); cada domínio self-canonical.
- [ ] **Wikidata/Wikipedia** avaliados quando houver notabilidade real.
- [ ] *(SHOULD)* **`llms.txt`** na raiz de cada domínio, gerado/curado com o conteúdo, coerente com a página — não bloqueia publicação.
- [ ] **Política de crawler de IA** declarada em `robots.txt` por bot, **permitindo por default**, com decisão em ADR.
- [ ] `robots.txt` **não** usado como controle de acesso — conteúdo restrito protegido por auth no servidor.
- [ ] **Feed** (RSS/Atom/JSON) quando há conteúdo serial.
- [ ] **Zero cloaking:** nenhum texto-isca oculto, nenhum `llms.txt` divergente, nenhuma promessa que a página não entrega.
- [ ] **Baseline e medição** de citações/menções/referral de IA registrados (ver `medicao.md`).
