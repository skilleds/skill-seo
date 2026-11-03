# Medição — instrumentação, KPIs, baseline/depois, log, experimentos e relatório

> Parte da skill **schematize-seo**. Este é o reference que dá corpo ao piso #10 dos pisos inegociáveis do `SKILL.md`: **medir antes e depois**. SEO sem medição é achismo, e achismo em SEO custa meses — você mexe, não sabe se subiu, e só descobre o estrago um trimestre depois. Aqui está *o que* instrumentar, *o que* medir, *quando* comparar e *o que* reportar.
>
> Vizinhos: canibalização e "páginas por query" ligam em `keywords-conteudo.md`; crawl budget e o que o crawler realmente visita ligam em `tecnico.md`; citações em IA como KPI novo ligam em `aio-llmo-geo.md`; a filosofia do funil crawl→index→rank→cita→converte está em `fundamentos.md`.

## Índice
- 1. O piso: medir antes e depois
- 2. Instrumentação mínima
- 3. O que o Google Search Console entrega
- 4. KPIs por etapa do funil
- 5. Baseline antes, reavaliação depois
- 6. Análise de log — o que o crawler realmente visita
- 7. Experimentos de SEO
- 8. Relatório — o que reportar e com que cadência
- 9. Checklist de medição

---

## 1. O piso: medir antes e depois

**MUST**
- **Nenhuma mudança relevante de SEO entra sem baseline.** Antes de mexer em title, arquitetura, canonical, conteúdo, internal linking ou schema, você **grava o estado atual** (§5) da(s) página(s) e da(s) query(s) afetadas.
- **Toda mudança é reavaliada depois** da janela de maturação (§5). Se não dá pra medir o efeito, não dá pra afirmar que funcionou — e não se afirma.
- **A unidade de medição é a query e a página, não o site inteiro.** "O tráfego subiu" não prova que *sua* mudança funcionou; a query e a URL que você tocou provam.

**VETADO**
- Declarar vitória por sensação, por print isolado de um dia bom, ou por métrica de vaidade (§8) que não liga a nenhuma decisão.
- Comparar períodos de sazonalidade diferente sem dizer (Black Friday vs. janeiro não é "queda").

---

## 2. Instrumentação mínima

Antes de medir qualquer coisa, o mínimo tem que estar de pé. Sem isso, você está cego.

| Ferramenta | Papel | Piso |
|---|---|---|
| **Google Search Console** | verdade sobre busca do Google: queries, páginas, posição, CTR, indexação, CWV, sitemaps | **MUST** — uma **propriedade por domínio** |
| **Analytics privacy-first** | comportamento no site: sessões, conversões, origem do tráfego | **MUST** — sem cookie invasivo, consentimento respeitado |
| **Rank tracker** | posição por query/dia/dispositivo/local, além do que o GSC amostra | **SHOULD** — opcional, mas útil onde a posição importa |
| **Coletor de log de servidor** | o que o crawler de fato requisitou (§6) | **SHOULD** — MUST em site grande |

**MUST — GSC por propriedade separada (a casa tem 4)**
- `net`, `org`, `me` e `com.br` são **propriedades separadas** no Search Console. Cada domínio é uma propriedade própria, verificada, com o **sitemap daquele domínio** submetido e o **relatório daquele domínio** monitorado. Não existe "o GSC do site" — existem quatro.
- Não misture os números de domínios diferentes num só painel como se fosse um só funil. Cada propriedade tem seu baseline, sua indexação, sua canibalização. Isso amarra direto na estratégia multi-domínio (self-canonical por propriedade — ver `internacional-multidominio.md`).

**MUST — analytics privacy-first**
- O desenho (tracking plan como contrato, consentimento, métricas de produto, A/B) é da `schematize-analytics`: `schematize-analytics → references/consentimento-lgpd.md` e `schematize-analytics → references/metricas.md`. Aqui só interessa ligar a **origem orgânica** à conversão.
- Consentimento respeitado, sem PII em URL/evento, retenção declarada. A medição não pode virar o vazamento que a casa proíbe.

**SHOULD**
- Rank tracker onde a posição orgânica move receita (páginas comerciais, keywords de topo do funil). Onde não move, o GSC basta.

---

## 3. O que o Google Search Console entrega

O GSC é a fonte da verdade sobre como o Google vê **aquele domínio**. Domine o que cada relatório dá.

| Relatório | Entrega | Use para |
|---|---|---|
| **Performance — Queries** | por que termo você aparece: impressões, cliques, CTR, posição média | achar query com impressão e CTR baixo (title/meta fracos), query em posição 5–15 (empurrável) |
| **Performance — Páginas** | quais URLs recebem impressão/clique | ver se a página *certa* rankeia pra intenção *certa* |
| **CTR e posição média** | taxa de clique e posição amostrada | diagnosticar: posição boa + CTR baixo = snippet fraco; posição ruim = problema de rank |
| **Cobertura / Indexação de páginas** | o que está indexado, o que foi excluído e por quê | caçar `noindex` acidental, canonical errada, "descoberta não indexada", soft 404 |
| **Core Web Vitals** | LCP/INP/CLS de campo por grupo de URL | CWV é fator de rank — a correção delega ao `schematize-web`, a medição é aqui |
| **Sitemaps** | sitemaps submetidos, lidos, com erro | confirmar que o inventário de URLs foi descoberto (um sitemap por propriedade) |
| **Removals / Manual Actions / Security** | penalização manual, problema de segurança | vigiar sempre — penalização mata todo o resto |

### 3.1 Detecção de canibalização via "páginas por query"

**MUST** — Este é o uso mais afiado do GSC e o piso #2 da casa (uma intenção por URL) em forma medível:
- No relatório de **Performance**, filtre por **uma query** e olhe a aba **Páginas**. Se **mais de uma URL** aparece rankeando pra mesma query ao longo do tempo — e nenhuma fixa uma boa posição, elas se revezam, ou a "errada" ganha —, é **canibalização**.
- Sintoma clássico: posição oscilando, CTR pingado entre duas URLs, nenhuma consolida o topo.
- O diagnóstico é aqui; o tratamento (consolidar, diferenciar intenção, ou 301) está em `keywords-conteudo.md`.

---

## 4. KPIs por etapa do funil

Meça o funil inteiro, em ordem. Um número no fim (conversão) sem os do meio não diz *onde* quebrou.

| Etapa | KPI | Fonte | Pergunta que responde |
|---|---|---|---|
| Descoberta | **páginas indexadas** / submetidas | GSC Indexação | O Google achou e aceitou minhas páginas? |
| Visibilidade | **impressões** | GSC Performance | Estou aparecendo para as buscas certas? |
| Atração | **cliques** | GSC Performance | Estou trazendo gente? |
| Ranking | **posição média** (por query) | GSC / rank tracker | Estou bem posicionado onde importa? |
| Eficiência do snippet | **CTR** | GSC Performance | Quem me vê, clica? |
| Resultado | **conversões** de tráfego orgânico | analytics | O tráfego vira valor? |
| **Novo — IA** | **citações em respostas de IA** | monitoramento de AIO/answer engines | Estou sendo *citado*, não só rankeado? |

**MUST**
- **Citações em IA são KPI de primeira classe**, não curiosidade. AI Overviews e answer engines respondem sem clique; aparecer como fonte citada é o novo "posição 1". Como instrumentar, o que conta como citação e a disciplina de conteúdo citável estão em `aio-llmo-geo.md` — aqui o piso é: **isto entra no relatório**.
- Não confunda etapas. **CTR baixo com posição boa** é problema de snippet (title/meta/schema), não de rank. **Posição boa e conversão baixa** é problema de página/oferta, não de SEO. O funil separa o diagnóstico.

**VETADO**
- Otimizar cliques ignorando conversão (tráfego que não converte é custo).
- Reportar só o topo do funil (impressões) porque é o número que sempre sobe.

---

## 5. Baseline antes, reavaliação depois

**MUST — o ritual de toda mudança relevante:**

1. **Antes.** Grave, para as queries e páginas que a mudança vai tocar: posição média, impressões, cliques, CTR, estado de indexação, e (quando aplicável) citação em IA. Anote a **data** e o **escopo** da mudança.
2. **Mude** — uma coisa por vez, ou um grupo coeso, para o efeito ser atribuível.
3. **Espere a janela de maturação.** SEO não é instantâneo: o Google recrawleia, reprocessa e reordena.
4. **Depois.** Meça os mesmos KPIs, mesma janela, e **compare contra o baseline** — não contra a sensação.

| Tipo de mudança | Janela típica para reavaliar |
|---|---|
| On-page (title/meta/H1/conteúdo) | **4–8 semanas** |
| Arquitetura / internal linking | 4–8 semanas (recrawl + reprocessamento) |
| Técnico (indexação, canonical, CWV) | 2–8 semanas, conforme a frequência de crawl |
| Conteúdo novo / cluster | 8+ semanas (autoridade leva tempo) |

**MUST**
- A janela padrão da casa é **4–8 semanas**. Antes disso, o número é ruído — não conclua.
- Sempre compare **período contra período comparável** (mesma duração, atento à sazonalidade), não "esta semana vs. semana passada" quando houve feriado, campanha ou pico.

---

## 6. Análise de log — o que o crawler realmente visita

O GSC diz o que foi *indexado*; o log do servidor diz o que o crawler **de fato requisitou**. São coisas diferentes, e a diferença é dinheiro (crawl budget).

**SHOULD (MUST em site grande / muitas URLs)**
- Analise o log de acesso do servidor filtrando os user-agents dos crawlers legítimos (validando por reverse DNS — user-agent mente).

| Sinal no log | Leitura |
|---|---|
| Crawler gastando hits em URL de filtro/parâmetro/lixo | **crawl budget desperdiçado** — bloqueie/`noindex`/canonicalize (ver `tecnico.md`) |
| Página importante **raramente** ou nunca visitada | descoberta/linkagem fraca — reforce internal linking e sitemap |
| Muitos 404/500/redirect em cadeia servidos ao crawler | erro técnico comendo budget — corrija status/redirects |
| Frequência de crawl de páginas-chave | proxy de "quão fresca" o Google mantém aquela URL |

**MUST**
- O que você aprende no log **liga direto a `tecnico.md`** (crawl budget, robots, status, arquitetura). A medição aponta o problema; o `tecnico.md` traz a correção.

---

## 7. Experimentos de SEO

Quando não dá pra saber se uma tática funciona no seu contexto, **teste** — com controle, não com fé.

**SHOULD — desenho de experimento:**
- Pegue um **grupo de páginas similares** (mesmo template/tipo/intenção). Aplique a mudança em **um subconjunto** (grupo de teste) e deixe o resto igual (**grupo de controle**).
- Meça **os dois grupos** na mesma janela (§5). O efeito é a diferença **teste vs. controle** — isso desconta sazonalidade e mudança de algoritmo, que atingem os dois igual.
- **Uma variável por experimento.** Mudou title *e* schema *e* internal link ao mesmo tempo? Não sabe qual moveu.

**MUST**
- Registre hipótese, escopo, data de início, métrica-alvo e resultado (deu, não deu, inconclusivo). Experimento sem registro é anedota.
- Resultado positivo e atribuível → **role para o resto do grupo**. Inconclusivo → não role, e não venda como vitória.

**VETADO**
- Chamar de "experimento" uma mudança global sem controle — aí é só uma aposta com nome bonito.

---

## 8. Relatório — o que reportar e com que cadência

O relatório existe para **decidir**, não para impressionar. Todo número reportado responde a uma pergunta e sustenta uma ação.

**MUST — reporte, por propriedade (os 4 domínios são 4 relatórios):**
- O **funil** (§4): indexadas → impressões → cliques → posição média → CTR → conversões → **citações em IA**.
- **O que mudou no período**, com baseline vs. depois (§5) das mudanças que já maturaram.
- **Ganhos e perdas por query/página** — as que subiram, as que caíram, e a hipótese do porquê.
- **Alertas**: penalização manual, queda de indexação, CWV saindo do verde, canibalização nova detectada (§3.1).

| Cadência | Conteúdo |
|---|---|
| **Semanal (leve)** | anomalias e alertas — queda súbita, de'sindexação, erro no GSC |
| **Mensal** | funil por propriedade, ganhos/perdas, status das mudanças em maturação |
| **Trimestral** | resultado dos experimentos, evolução vs. baseline do trimestre, decisões de estratégia |

**VETADO — métricas de vaidade:**
- Reportar número que sempre sobe e não liga a decisão: "impressões totais" sem contexto de query, "keywords rankeadas" contando posição 90, tráfego agregado sem separar orgânico, "domain rating" de terceiro como se fosse resultado.
- Um número entra no relatório **só se** alguém pode agir sobre ele. Se ninguém decide nada com aquele número, ele sai.

---

## 9. Checklist de medição

Antes de dizer que uma mudança de SEO está "medida", tudo abaixo tem que fechar:

**Instrumentação**
- [ ] GSC configurado como **propriedade separada para cada domínio** (net/org/me/com.br), verificado
- [ ] **Sitemap de cada domínio** submetido na propriedade daquele domínio
- [ ] Analytics privacy-first no ar, conversões orgânicas rastreadas, consentimento respeitado
- [ ] Rank tracker ligado onde a posição move receita (SHOULD)
- [ ] Coleta de log de servidor disponível (MUST em site grande)

**Baseline (antes)**
- [ ] Estado atual gravado para as queries e páginas afetadas: posição, impressões, cliques, CTR, indexação
- [ ] Citação em IA registrada no baseline quando aplicável (ver `aio-llmo-geo.md`)
- [ ] Data e escopo da mudança anotados

**Funil e canibalização**
- [ ] KPIs do funil medidos em ordem (indexadas → impressões → cliques → posição → CTR → conversões → citações IA)
- [ ] "Páginas por query" checado no GSC — nenhuma query com múltiplas URLs se revezando (§3.1; trata em `keywords-conteudo.md`)

**Reavaliação (depois)**
- [ ] Janela de maturação respeitada (**4–8 semanas** on-page; ver tabela §5)
- [ ] Mesmos KPIs medidos e comparados contra o baseline, período contra período comparável
- [ ] Efeito atribuído à mudança (uma variável, ou grupo teste vs. controle no experimento)

**Log e crawl (quando aplicável)**
- [ ] Log analisado: crawl budget não desperdiçado em lixo, páginas-chave sendo visitadas (liga em `tecnico.md`)

**Relatório**
- [ ] Relatório por propriedade, na cadência definida (semanal/mensal/trimestral)
- [ ] Zero métrica de vaidade — todo número reportado sustenta uma decisão
- [ ] Alertas cobertos: penalização, queda de indexação, CWV, canibalização nova
