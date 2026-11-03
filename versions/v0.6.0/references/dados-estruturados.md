<!-- cross-skill: seo-i18n.md -> schematize-web -->
# Dados Estruturados — schema.org / JSON-LD

> Parte da skill **schematize-seo**. Governa a **disciplina** dos dados estruturados: que tipos a casa marca, com que conteúdo, e o que nunca se marca. A **implementação** no frontend (injetar o `<script>` no `metadata`/head do App Router, gerar por página) delega ao `schematize-web` → `references/seo-i18n.md` §46.2. Leia junto com `aio-llmo-geo.md` — o structured data daqui é a base que a busca e a IA consomem — e com `internacional-multidominio.md` para a mesma entidade cross-domain.

Convenção de leitura: **MUST** = regra (desvio bloqueia ou exige ADR); **SHOULD** = padrão (desvio justificado no PR); **VETADO** = piso, sem exceção.

---

## Por que dados estruturados

Marcar o conteúdo com schema.org via JSON-LD entrega **duas coisas de uma vez**:

1. **Rich results na busca** — estrelas de avaliação, breadcrumb, cartão de software, FAQ expansível, curso. Aumentam CTR e ocupam mais SERP.
2. **Entendimento por máquina e por IA** — o markup diz *o que a página é* em linguagem inequívoca. Busca, knowledge graph e answer engines (AI Overviews, ChatGPT, Perplexity) leem structured data para **identificar a entidade e citar com confiança**. Sem markup, a máquina adivinha; com markup, ela sabe. O lado de descoberta por IA está em `aio-llmo-geo.md` — o JSON-LD é o alicerce dele.

**MUST** — toda página que tem um tipo aplicável carrega o JSON-LD correspondente. Página institucional → `Organization`; home → `WebSite`; página do produto → `SoftwareApplication`; post → `BlogPosting`; navegação → `BreadcrumbList`.

**VETADO** — marcar rich result que a página **não mostra**. É violação das diretrizes do Google e vira **penalização manual** ("ação manual por dados estruturados com spam"), que derruba os rich results do domínio inteiro. Ver `anti-padroes.md`.

---

## Formato: JSON-LD (preferido)

**MUST**
- Usar **JSON-LD** (`<script type="application/ld+json">`), não Microdata nem RDFa. É o formato recomendado pelo Google, desacopla o markup do HTML visível e é trivial de gerar por página.
- Colocar o bloco no `<head>` **ou** no fim do `<body>` — tanto faz para o crawler; padronize um lugar por projeto.
- **Um bloco por tipo**, com `@context` e `@type` corretos. Vários tipos na mesma página → vários `<script>` **ou** um `@graph` (array de nós) — não misture tipos soltos no mesmo objeto sem `@graph`.
- Todo `@id` é **URL absoluta** e estável, para os nós se referenciarem entre páginas (ex.: o `Organization` referenciado pelo `publisher` do `Article`).
- Alinhar com o `<html lang>` e o `og:locale`: campo `inLanguage` coerente com o idioma real da página (`schematize-web` → `references/seo-i18n.md` §47).
  **O idioma vem da tabela de domínios** (`internacional-multidominio.md`): `.net`, `.org` e `.me`
  são **en**; `.com.br` é **pt-BR**. Exemplo com `inLanguage: "pt-BR"` num `@id` de `.net` — que era
  o caso aqui — ensina o padrão errado, e o markup errado é copiado com muito mais facilidade do que
  a prosa certa.

**VETADO**
- JSON-LD que descreve conteúdo **ausente** da página (ver regras abaixo).
- Copiar/colar um bloco de outra página sem trocar URL, título, datas e entidade (gera dado mentiroso e duplicado).

---

> **A entidade de marca é UMA, e ela tem um dono.** O `Organization` aparece nos quatro domínios,
> mas **é a mesma entidade**: o `@id` (e o `url`) apontam para o **domínio-âncora**, e os outros
> entram em `sameAs`. Ter duas âncoras diferentes escritas em dois references — que era o caso aqui
> — não é detalhe de documentação: o buscador passa a ver **duas organizações** com o mesmo nome, e a
> autoridade que deveria somar se divide. **Fonte única da âncora e do papel de cada domínio:**
> `internacional-multidominio.md`.

## Catálogo dos tipos da casa

| Tipo | Onde usar | Domínio típico |
|---|---|---|
| `Organization` | página institucional, sobre, rodapé de **todo** domínio | presença em todos, com **`@id` único** apontando o domínio-âncora — a definição é do `internacional-multidominio.md` §"Entidade de marca", que é o reference central da estratégia de domínios |
| `WebSite` | home de cada propriedade (sem `SearchAction`: o searchbox morreu) | todos |
| `SoftwareApplication` | página do produto **schematize** (CLI) | `.net` comercial |
| `Product` + `Offer` | oferta paga/plano, quando existir | `.net` |
| `Course` | cursos futuros, linkados na plataforma **educe** | `.net` / `educe` |
| `Article` / `BlogPosting` | blog e conteúdo editorial | `.net` / `.com.br` |
| `BreadcrumbList` | qualquer página com hierarquia de navegação | todos |
| `Person` | autoria de post, página de autor (E-E-A-T) | blog |

### Organization

Identidade da casa. Uma organização, referenciada por `@id` em todo o resto (author/publisher). `sameAs` lista os perfis oficiais (GitHub, LinkedIn, X) — sinal forte de entidade para o knowledge graph. A **mesma entidade** aparece nos quatro domínios; cada domínio é self-canonical, mas todos apontam para o mesmo `Organization` conceitual e se ligam por `sameAs`/links (nunca por canonical cruzado — ver `internacional-multidominio.md`).

```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "@id": "https://schematize.net/#org",
  "name": "Schematize",
  "url": "https://schematize.net",
  "logo": "https://schematize.net/logo.png",
  "sameAs": [
    "https://github.com/schematizeme",
    "https://www.linkedin.com/company/schematize",
    "https://x.com/schematize"
  ]
}
```

**MUST** — `logo` é URL absoluta de imagem real; `sameAs` só lista perfis que a casa controla. Um `@id` só para a organização, reusado cross-domain.

### WebSite

Um por propriedade. *(O `SearchAction`/`potentialAction` para o **sitelinks searchbox** era prescrito aqui; o rich result está morto — ver o bloco "Rich results MORTOS". Declará-lo hoje não gera a caixa de busca no resultado.)*

```json
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "@id": "https://schematize.net/#website",
  "url": "https://schematize.net",
  "name": "Schematize",
  "inLanguage": "en",
  "publisher": { "@id": "https://schematize.net/#org" }
}
```


### SoftwareApplication (schematize)

Marque `applicationCategory`, **`operatingSystem` com os SOs que você realmente entrega** e `offers`
com `price: "0"` quando for gratuita.

> **`operatingSystem` é fato sobre o produto, não constante da skill.** ✔ Verificado em 2026-08-21:
> o `schematize-updater` publica binário para **Linux, macOS e Windows** — ou seja, "Linux" sozinho
> **já não descreve** o que a casa distribui. Um markup que declara menos SOs do que o produto
> suporta **tira você do resultado** de quem procura pelo SO que você atende; um que declara mais é
> **markup falso** (e rich result inventado é penalização). A regra é: **espelhe a matriz de release**
> — e quando ela mudar, o markup muda junto. Aceita lista: `"Linux, macOS, Windows"`.

```json
{
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "schematize",
  "applicationCategory": "DeveloperApplication",
  "operatingSystem": "Linux, macOS, Windows",
  "url": "https://schematize.net/schematize",
  "downloadUrl": "https://github.com/schematizeme/schematize-cli",
  "softwareVersion": "0.1.0",
  "offers": {
    "@type": "Offer",
    "price": "0",
    "priceCurrency": "BRL"
  },
  "publisher": { "@id": "https://schematize.net/#org" }
}
```

**MUST** — `aggregateRating` **só se houver avaliação real e visível** na página (nota agregada de usuários exibida ao leitor). Nota inventada para ganhar estrela é o erro que mais atrai penalização manual. Sem avaliação real → **omita o campo**.

### Product / Offer

Para oferta paga ou plano, quando existir. `Product` descreve o item; `Offer` o preço e a disponibilidade. Mesma regra de `aggregateRating`: só com avaliação real.

```json
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "Schematize Pro",
  "description": "Plano com skills privadas e suporte.",
  "offers": {
    "@type": "Offer",
    "price": "49.00",
    "priceCurrency": "BRL",
    "availability": "https://schema.org/InStock",
    "url": "https://schematize.net/pro"
  }
}
```

### Course (cursos → educe)

Os cursos futuros são linkados na plataforma **educe**. `Course` descreve o curso; `provider` referencia a organização.

```json
{
  "@context": "https://schema.org",
  "@type": "Course",
  "name": "Schematize na prática",
  "description": "Curso introdutório da CLI schematize.",
  "url": "https://educe.schematize.net/cursos/schematize-na-pratica",
  "provider": { "@id": "https://schematize.net/#org" },
  "inLanguage": "en"
}
```

**SHOULD** — para o rich result de curso, adicione `hasCourseInstance` (modalidade, data, carga) quando a oferta tiver turma/data definida.

### Article / BlogPosting

Todo post do blog. Exige `author` (Person), `datePublished` e, quando editado, `dateModified`. `publisher` referencia a `Organization`.

```json
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "headline": "Como versionar skills com o schematize",
  "url": "https://schematize.com.br/blog/versionar-skills",
  "datePublished": "2026-08-01",
  "dateModified": "2026-08-05",
  "inLanguage": "pt-BR",
  "author": { "@type": "Person", "name": "Tom Volucer", "url": "https://schematize.com.br/autores/tom" },
  "publisher": { "@id": "https://schematize.net/#org" },
  "image": "https://schematize.com.br/blog/versionar-skills/cover.png"
}
```

**MUST** — `headline` ≤ 110 caracteres; `datePublished` verdadeira; `author` é uma pessoa real (E-E-A-T — ver `autoridade-eeat.md`), não "Admin" nem a marca.

### BreadcrumbList

A trilha de navegação. Espelha o breadcrumb **visível** na página; posições em ordem.

```json
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    { "@type": "ListItem", "position": 1, "name": "Blog", "item": "https://schematize.net/blog" },
    { "@type": "ListItem", "position": 2, "name": "Versionar skills", "item": "https://schematize.net/blog/versionar-skills" }
  ]
}
```

### FAQPage — **MORTO como rich result** (o formato de conteúdo continua valendo)

✔ **Verificado em 2026-08-21:** o FAQ rich result **deixou de aparecer na busca em 07/05/2026** (data do aviso de depreciação; fontes secundárias, não confirmei na página do Google <!-- reverificar -->) e
a documentação dele foi **removida** do Google Search Central em 12/06/2026. **Não marque
`FAQPage`** — e remova a marcação onde ela existir: é manutenção com retorno zero.

**O que NÃO morreu:** o **bloco de perguntas e respostas visível na página**. Ele continua sendo
uma das formas mais citáveis por resposta de IA (`aio-llmo-geo.md`) e continua servindo ao
usuário. O que sai é o JSON-LD e a expectativa de estrela no SERP, não a seção da página.


### Person (autoria / E-E-A-T)

Página de autor e o `author` dos posts. Amarra autoria a uma entidade real com histórico — sinal de E-E-A-T que a busca e a IA usam para confiar no conteúdo.

```json
{
  "@context": "https://schema.org",
  "@type": "Person",
  "@id": "https://schematize.net/autores/tom#person",
  "name": "Tom Volucer",
  "url": "https://schematize.net/autores/tom",
  "jobTitle": "Engenheiro",
  "worksFor": { "@id": "https://schematize.net/#org" },
  "sameAs": ["https://github.com/tom", "https://www.linkedin.com/in/tom"]
}
```

---

## Regras de coerência (MUST / VETADO)

**MUST**
- O JSON-LD **reflete o conteúdo visível**. Preço no markup = preço na tela; FAQ no markup = FAQ na página; avaliação no markup = avaliação exibida.
- **Um bloco por tipo** por página (ou `@graph`). Dois `Article` na mesma URL confundem o parser.
- Reuse a mesma entidade por `@id` (Organization, Person) em vez de redefinir campos divergentes em cada página.
- `inLanguage`, `og:locale` e `<html lang>` **coerentes** entre si (`schematize-web` → `references/seo-i18n.md` §47).
- Datas em ISO 8601; URLs absolutas; imagens reais e acessíveis.

**VETADO**
- Marcar rich result ausente da página (FAQ oculto, review inventado, preço que não está na tela).
- `aggregateRating`/`review` sem avaliação real e visível.
- Copiar bloco entre páginas sem trocar os dados da página.
- JSON-LD como substituto de conteúdo: markup não compensa página *thin* (ver `keywords-conteudo.md`).

---

## Validação (obrigatória no fluxo de revisão)

**MUST** — todo JSON-LD passa por validação antes do merge:

| Ferramenta | Para quê |
|---|---|
| **Rich Results Test** (Google) | confirma se a página é elegível a rich result e qual |
| **Schema Markup Validator** (schema.org) | valida sintaxe e vocabulário schema.org (mesmo sem rich result) |
| **Search Console → Melhorias / Ações manuais** | monitora erros e penalização em produção |

Sem erro no validador **e** o rich result renderiza no preview → passou. Aviso ("warning") de campo recomendado ausente é SHOULD-corrigir, não bloqueia. Erro é bloqueio.

---

## Erros comuns

| Erro | Consequência | Correção |
|---|---|---|
| Rich result marcado sem conteúdo visível | ação manual, perde rich result do domínio | marcar só o que está na tela |
| `aggregateRating` inventado | penalização | omitir sem avaliação real |
| JSON-LD copiado entre páginas | dado mentiroso/duplicado | gerar por página, dados reais |
| Canonical cruzado + JSON-LD divergente entre domínios | autoridade jogada fora | self-canonical; entidade única por `@id` (`internacional-multidominio.md`) |
| `author` = "Admin" ou a marca | E-E-A-T fraco | `Person` real com `sameAs` (`autoridade-eeat.md`) |
| Datas erradas/ausentes em Article | perde elegibilidade | `datePublished`/`dateModified` verdadeiras |
| `inLanguage` divergente de `<html lang>` | sinal de idioma confuso | alinhar locale (`seo-i18n.md`) |
| Vários tipos soltos no mesmo objeto | parser ignora | um `<script>` por tipo ou `@graph` |
| `SearchAction` para sitelinks searchbox | rich result **morto** (✔ 2026-08-21) | não declarar por causa dele |

---

## Checklist (pré-publicação, por página)

- [ ] O tipo schema.org **certo** para a página está marcado (Organization/WebSite/SoftwareApplication/Product/Course/Article/BreadcrumbList/Person).
- [ ] JSON-LD em `<script type="application/ld+json">`, um bloco por tipo (ou `@graph`).
- [ ] Todo campo do markup **existe visível** na página (preço, FAQ, avaliação, breadcrumb).
- [ ] `Organization` com `logo`, `url` e `sameAs` só de perfis controlados; reusada por `@id`.
- [ ] `SoftwareApplication` com **`operatingSystem` espelhando a matriz de release** (não uma constante herdada), `applicationCategory` e `offers` `price` `"0"`; **sem** `aggregateRating` inventado.
- [ ] `Article`/`BlogPosting` com `author` (Person real), `datePublished` e `publisher` = `Organization`.
- [ ] **Nenhum** `FAQPage`/`HowTo`/`SearchAction` marcado — os três saíram da galeria de rich results (✔ 2026-08-21). O conteúdo (Q&A, passo a passo, busca interna) fica; a marcação sai.
- [ ] URLs absolutas, datas ISO 8601, imagens reais e acessíveis.
- [ ] `inLanguage` coerente com `<html lang>` e `og:locale`.
- [ ] Self-canonical por propriedade; nenhuma entidade canonicaliza cross-domain (`internacional-multidominio.md`).
- [ ] Passou no **Rich Results Test** e no **Schema Markup Validator**, sem erro.
- [ ] Sem ação manual pendente no Search Console.
