# Fundamentos de SEO — como busca e IA encontram, entendem e citam a casa

> Parte da skill **schematize-seo**. Este arquivo é a **base conceitual normativa**: como mecanismos de busca e respostas de IA funcionam, os pilares, a intenção de busca, E-E-A-T, o funil e as SERP features. O detalhe operacional está nos irmãos — ver `tecnico.md` (crawl/index/render, Core Web Vitals, canonical, sitemap), `dados-estruturados.md` (schema/JSON-LD), `keywords-conteudo.md` (produção e relevância), `autoridade-eeat.md` (links e reputação), `internacional-multidominio.md` (os 4 domínios e a regra de ouro sem canonical cruzado) e `aio-llmo-geo.md` (AI Overviews, LLMO/GEO, markup legível por máquina).

## Como ler

- **MUST / Obrigatório** — regra. Desvio bloqueia entrega ou exige ADR.
- **SHOULD / Recomendado** — padrão. Desvio precisa de justificativa no PR.
- **VETADO / Proibido** — não existe atalho. Não se faz, não se cogita. Burlar é incidente, não decisão técnica.

Filosofia da casa em uma frase: **SEO é consequência de ser genuinamente a melhor resposta para uma intenção + tornar essa resposta legível pra máquina.** Não é truque, não é volume, não é palavra repetida. Quem tenta enganar o ranking em vez de merecer o ranking paga com penalização, volatilidade e retrabalho. Faça o conteúdo valer a leitura; depois garanta que o crawler e a IA conseguem lê-lo, entendê-lo e atribuí-lo.

---

## 1. Como o mecanismo de busca funciona (crawl → index → rank → SERP)

Quatro etapas. Falha em qualquer uma zera as seguintes — não adianta rankear conteúdo que nunca foi indexado, nem indexar página que o crawler não alcança.

| Etapa | O que acontece | O que a casa controla | Onde falha na prática |
|---|---|---|---|
| **Crawl** | O bot descobre e busca a URL (segue links, lê sitemap) | `robots.txt`, sitemap, links internos, status HTTP, velocidade de resposta | Bloqueio no `robots.txt`, página órfã (sem link), 5xx, JS que esconde conteúdo |
| **Render/Index** | O conteúdo é processado (renderizando JS quando preciso) e armazenado | HTML no servidor (SSR/SSG), canonical, `noindex` correto, dados estruturados | Conteúdo só no cliente, canonical errado, duplicação, `noindex` acidental |
| **Rank** | O índice é ordenado por relevância + qualidade + autoridade pra cada query | Relevância ao intento, E-E-A-T, links, sinais de experiência (CWV) | Conteúdo raso, intenção errada, autoridade fraca, página lenta |
| **SERP** | O resultado é montado (10 azuis + features) e o usuário decide clicar | `<title>`, `description`, dados estruturados, rich results | Snippet genérico, sem estruturado, título truncado/repetido |

**MUST**
- Garanta que **cada etapa passa antes de otimizar a próxima.** Antes de brigar por posição, confirme index (`site:` no buscador, Search Console). Antes de index, confirme crawl (status 200, sem bloqueio, com link interno). Detalhe operacional em `tecnico.md`.
- **HTML renderizado no servidor** pro conteúdo existir sem depender de JS. Conteúdo que só aparece após hidratação é conteúdo que arrisca não ser indexado nem citado por IA.

**VETADO**
- Presumir que "publiquei, logo vai rankear". Publicação é o começo do crawl, não o fim do trabalho.

---

## 2. Como respostas de IA mudaram o jogo (a 5ª etapa: CITA)

O funil clássico terminava em clique na SERP. Hoje há uma camada nova: **AI Overviews (Google), ChatGPT, Perplexity, Claude e afins sintetizam a resposta e citam fontes** — muitas vezes sem o usuário clicar em nada (zero-click). O jogo deixou de ser só "aparecer na lista"; passou a ser **"ser a fonte que a IA escolhe citar"**.

O funil da casa, então, é de cinco etapas:

```
CRAWL → INDEX → RANK → CITA (IA) → CONVERTE
```

- **CITA** — a página é recuperada e usada como fonte por uma resposta de IA (com ou sem link). Ser citado gera autoridade e tráfego qualificado mesmo sem ranking #1 clássico.
- **CONVERTE** — o objetivo de negócio se realiza (assinar, instalar o `schematize`, contratar consultoria). Na casa, **conversão mora em schematize.net** — os "links que importam" apontam pra lá (ver `internacional-multidominio.md`).

**MUST**
- Trate **CITA como etapa de primeira classe**, não como bônus. Conteúdo estruturado, factual, com fonte e data, atribuível e legível por máquina é o que a IA cita. O como está em `aio-llmo-geo.md`.
- Escreva de forma **extraível**: resposta direta no topo (a pergunta respondida em 1–2 frases antes do aprofundamento), fatos verificáveis, definições limpas, listas e tabelas. É isto que vira trecho citado.

**SHOULD**
- Meça presença em IA (aparições em AI Overviews, citações em Perplexity/ChatGPT) além de posição clássica. O KPI da casa não é só rank: é rank + citação + conversão em .net.

**VETADO**
- Otimizar só pra SERP azul clássica e ignorar que boa parte das intenções informacionais hoje termina numa resposta de IA sem clique.

---

## 3. Os três pilares

Todo trabalho de SEO se divide em três pilares. Os três precisam existir; um forte não compensa outro ausente.

| Pilar | Pergunta que responde | Sinais principais | Skill irmã |
|---|---|---|---|
| **Técnico** | A máquina consegue **acessar, renderizar e entender**? | Crawlabilidade, index, velocidade (CWV), mobile, HTTPS, canonical | `tecnico.md` · **dados estruturados: `dados-estruturados.md`** |
| **Conteúdo / relevância** | Esta página é a **melhor resposta** pra intenção? | Cobertura do tópico, profundidade, atualidade, clareza, extraibilidade | `keywords-conteudo.md` |
| **Autoridade** | Por que **confiar** nesta fonte? | Backlinks de qualidade, menções, reputação da marca, E-E-A-T | `autoridade-eeat.md` |

**MUST**
- Diagnostique problema de ranking **pelo pilar**: técnico (não indexa/lento), relevância (não responde à intenção), ou autoridade (não confiam na fonte). Tratar o pilar errado desperdiça esforço.

Regra de bolso: **técnico destrava, conteúdo qualifica, autoridade decide o empate.**

---

## 4. Intenção de busca (search intent)

Toda query carrega uma intenção. **A página tem que casar com a intenção**, ou não rankeia por mais bem-feita que seja. Rankear a página errada pra uma intenção é como responder outra pergunta: educadamente ignorado.

| Intenção | O usuário quer | Sinais na query | Formato de página certo | Domínio da casa |
|---|---|---|---|---|
| **Informational** | Aprender/entender | "como", "o que é", "guia", "erro X" | Artigo, tutorial, doc, FAQ | .org / .me / .com.br |
| **Navigational** | Chegar a algo específico | nome de marca/produto ("schematize CLI") | Home, página de produto, doc oficial | .net (produto), .me (marca) |
| **Commercial** | Comparar antes de decidir | "melhor", "vs", "review", "alternativa a" | Comparativo, landing de recurso, caso | .net |
| **Transactional** | Agir agora | "comprar", "preço", "instalar", "contratar" | Página de preço/checkout/instalação | .net |

**MUST**
- **Mapeie a intenção antes de escrever.** Cheque a SERP real da query-alvo: o que o buscador já premia (artigo? comparativo? produto?) revela a intenção que ele atribui. Combata o formato dominante, não invente outro.
- **Conteúdo transacional/comercial que converte → schematize.net.** Conteúdo informacional/institucional → domínio informacional (ver `internacional-multidominio.md`). Nunca canibalize colocando duas páginas da casa disputando a **mesma** query com a **mesma** intenção.

**VETADO**
- Forçar CTA de venda pesado numa página de intenção informacional (afasta e não converte), ou publicar artigo raso onde a intenção pede ferramenta/produto.

---

## 5. E-E-A-T (Experience, Expertise, Authoritativeness, Trust)

Framework do Google pra avaliar **qualidade e confiabilidade** de uma fonte. Não é fator de ranking direto medido por número — é o **conjunto de sinais** que sustenta por que a fonte merece rankear e ser citada. Importa mais quanto mais a informação afeta decisão do leitor (dinheiro, carreira, segurança — o chamado YMYL).

| Letra | O que é | Como a casa prova |
|---|---|---|
| **Experience** | Vivência de primeira mão | Escrever do que a casa realmente usa/construiu (ex.: o `schematize` no dia a dia); prints, dados próprios, casos reais |
| **Expertise** | Competência no assunto | Autoria identificada com credencial, profundidade técnica correta, sem erro factual |
| **Authoritativeness** | Ser referência reconhecida | Ser citado/linkado por outros, presença consistente, marca forte (.me, .com.br) |
| **Trust** | Confiabilidade (o centro) | HTTPS, dados corretos e datados, transparência (quem escreveu, quando), fonte das afirmações, sem enganação |

**MUST**
- **Autoria e data em conteúdo que aconselha.** `author` com identidade real, `datePublished`/`dateModified` verdadeiros (ver `references/dados-estruturados.md` desta skill e, no frontend, `schematize-web` → `references/seo-i18n.md` §46.2).
- **Afirmação factual tem fonte.** Número, benchmark, citação: com referência. É o que sustenta Trust e é o que a IA precisa pra citar com segurança.
- **Experience é o diferencial barato da casa**: escreva do que realmente fazemos. Conteúdo com vivência real bate conteúdo genérico raspado — e é o que a IA distingue como fonte primária.

**VETADO**
- Conteúdo YMYL anônimo, sem data, com afirmação sem fonte. Falha em Trust e não rankeia nem é citado.

---

## 6. SERP features (além dos 10 links azuis)

A SERP não é uma lista simples. Vários blocos disputam a atenção — e a posição #1 clássica pode estar abaixo de um featured snippet ou de um AI Overview. Conhecer cada feature é saber onde é possível aparecer.

| Feature | O que é | Como se ganha |
|---|---|---|
| **Featured snippet** | Caixa no topo com a resposta extraída de uma página | Responder a pergunta direta e concisa (parágrafo, lista ou tabela) já rankeando bem |
| **People Also Ask (PAA)** | Perguntas relacionadas expansíveis | Cobrir subperguntas do tópico com respostas curtas e diretas (formato Q&A no texto, sem marcação `FAQPage`) |
| **Sitelinks** | Links internos extras sob um resultado | Arquitetura de site clara, navegação e nomes de página inequívocos |
| **Knowledge panel** | Painel lateral sobre entidade (marca/pessoa) | Entidade bem definida (`Organization`/`Person` JSON-LD), consistência de dados, autoridade |
| **Rich results** | Resultado enriquecido (estrelas, preço, FAQ, breadcrumb) | Dados estruturados válidos que refletem o conteúdo real (**`dados-estruturados.md`** — o `tecnico.md` não trata de schema) |
| **AI Overview** | Resposta sintetizada por IA com fontes citadas | Conteúdo extraível, factual, atribuível (ver `aio-llmo-geo.md` e §2) |

**MUST**
- Estruture pra **featured snippet e PAA**: resposta direta primeiro, listas/tabelas onde o conteúdo pede. O mesmo formato extraível que ganha snippet é o que a IA cita.
- Use **dados estruturados válidos** que espelham o conteúdo visível (detalhe em `dados-estruturados.md`). Marcar o que não está na página é spam e arrisca penalização.

**SHOULD**
- Reserve featured snippet/PAA para conteúdo informacional; a conversão vem depois, pelo link pro .net.

---

## 7. Mitos a matar

Práticas mortas ou nocivas que ainda aparecem. **Não perca tempo com elas.**

| Mito | Realidade |
|---|---|
| **Meta keywords** (`<meta name="keywords">`) | **Ignorada há mais de uma década.** Não use — no máximo sinaliza amadorismo. Zero efeito em ranking. |
| **Densidade de keyword** ("repita a palavra X%") | Não existe percentual mágico. Repetição forçada é **keyword stuffing**, que penaliza. Escreva natural; cubra o tópico e seus sinônimos/entidades. |
| **Quanto mais páginas, melhor** | Volume de conteúdo raso dilui autoridade e canibaliza. **Uma página excelente > dez medianas.** |
| **Exact-match domain garante ranking** | Não. Autoridade e relevância decidem, não o nome do domínio. |
| **Comprar backlink em massa** | Risco de penalização. Autoridade se ganha merecendo link, não comprando (ver `autoridade-eeat.md`). |
| **SEO é uma configuração única** | É processo contínuo: index, medição, ajuste. O algoritmo e a SERP mudam. |
| **Esconder texto pro bot** (texto branco, cloaking) | **Spam. Penalização certa.** O que o bot vê tem que ser o que o humano vê. |

**MUST**
- Cubra o tópico por **entidades e intenção**, não por repetição de string. É assim que busca moderna e IA entendem relevância.

**VETADO**
- Keyword stuffing, texto escondido, cloaking, doorway pages, link comprado em massa. São spam; violam a filosofia da casa (merecer o ranking) e arriscam penalização que custa meses.

---

## 8. Filosofia da casa (fecho)

- **Seja a melhor resposta, de verdade.** Relevância e E-E-A-T primeiro; o resto é encanamento pra que a máquina consiga ler o que já é bom.
- **Torne legível pra máquina.** HTML no servidor, dados estruturados verdadeiros, formato extraível. Conteúdo bom que a máquina não lê não rankeia nem é citado.
- **Meça o funil inteiro** — crawl → index → rank → **cita** → converte. Otimizar só uma etapa engana o painel, não o negócio.
- **Um domínio, uma intenção, self-canonical, conectados por links; conversão no .net.** A regra de ouro dos 4 domínios está em `internacional-multidominio.md` — nunca canonical cruzado.

> Se a estratégia depende de enganar o buscador em vez de merecer a posição, está errada. SEO da casa é a recompensa de fazer certo — não um truque colado por cima.

---

## Checklist de fundamentos

- [ ] A intenção da query-alvo foi identificada (informational/navigational/commercial/transactional) checando a SERP real, e a página casa com ela
- [ ] A página passa cada etapa do funil na ordem: crawl (200, sem bloqueio, com link interno) → index (confirmado) → rank → cita → converte
- [ ] HTML renderizado no servidor: o conteúdo existe sem depender de JS
- [ ] Conteúdo extraível: resposta direta no topo, fatos verificáveis, listas/tabelas onde cabe (ganha snippet e citação de IA)
- [ ] E-E-A-T coberto: autoria identificada, data real, afirmações com fonte, vivência de primeira mão explícita
- [ ] Dados estruturados válidos que espelham o conteúdo visível (ver `tecnico.md`)
- [ ] Os três pilares diagnosticados: técnico destrava, conteúdo qualifica, autoridade decide
- [ ] Conversão aponta pra schematize.net; domínios distintos por intenção, self-canonical, sem canonical cruzado (ver `internacional-multidominio.md`)
- [ ] Zero mito: sem meta keywords, sem densidade forçada, sem texto escondido, sem link comprado
- [ ] Presença em IA considerada como etapa de citação (ver `aio-llmo-geo.md`), não só ranking clássico
