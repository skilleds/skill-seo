#!/usr/bin/env bash
# check-seo.sh — gate do piso de SEO sobre o HTML PUBLICADO (build/export estático do site).
#
# Motivo: os pisos da schematize-seo (SKILL.md, "Pisos inegociáveis") morrem em PR se só a prosa
# os cobra: canonical que cruza domínio da casa joga fora a autoridade do outro domínio; hreflang sem
# par é ignorado pelo Google; title/description duplicados canibalizam; robots que bloqueia tudo
# derruba o site inteiro. Tudo isso é decidível sobre o HTML servido, sem rede.
# Entrada: $1 = diretório com o HTML (ex.: out/, dist/, .next/server/app). Opções:
#   --host <dom[,dom2]> host(s) canônico esperado do site (obrigatório se os canonicals estão em >1 host).
# Regras (id): canonical-ausente · canonical-relativa · canonical-parametro · canonical-cruzado ·
#   hreflang-sem-xdefault · hreflang-sem-self · hreflang-sem-reciproco · title-ausente · title-duplicado ·
#   description-ausente · description-duplicada · h1-ausente · robots-ausente · robots-bloqueia-tudo ·
#   robots-sem-sitemap · sitemap-ausente · sitemap-sem-loc · host-ambiguo · waiver-sem-motivo · hreflang-conteudo-distinto.
#   hreflang entre hosts diferentes só com `<!-- seo-variant: slug -->` igual nas duas páginas (tradução 1:1).
# Páginas com <meta name="robots" content="...noindex..."> ficam fora das regras de página (noindex é
# intencional). Waiver rastreável: `<!-- seo-ok: <motivo> -->` no arquivo dispensa as regras daquela página.
# Saída: achados em stdout (`ERRO regra arquivo mensagem`). Exit 0 passa · 1 reprova · 2 nada a verificar
#   (sem HTML: "nada verificado" não é aprovação).
# EXCEÇÃO DECLARADA de strict mode (`schematize-shell` -> `references/piso.md` secao 1): COLETOR — varre
# tudo e soma os achados; com `set -e` o primeiro `grep` sem casamento (resultado normal aqui) abortaria.
set -uo pipefail
export LC_ALL=C.UTF-8

DIR="."; HOST=""
while [ $# -gt 0 ]; do
  case "$1" in
    --host) HOST="${2:-}"; shift 2 ;;
    -h|--help) sed -n '2,23p' "$0"; exit 0 ;;
    *) DIR="$1"; shift ;;
  esac
done
[ -d "$DIR" ] || { echo "check-seo: '$DIR' não é diretório" >&2; exit 2; }
DIR="$(cd "$DIR" && pwd)"

TMP="$(mktemp -d)"; trap 'rm -rf "${TMP:?}"' EXIT INT TERM
ERROS=0
erro() { echo "ERRO $1 $2 $3"; ERROS=$((ERROS+1)); }

mapfile -t HTMLS < <(find "$DIR" -type f -name '*.html' \
  -not -path '*/node_modules/*' -not -path '*/.git/*' | LC_ALL=C sort)
[ "${#HTMLS[@]}" -gt 0 ] || { echo "check-seo: nenhum .html em $DIR — nada verificado (isso não é aprovação)"; exit 2; }

# --- extração -----------------------------------------------------------------------------------
um() { tr '\n\r\t' '   ' < "$1"; }                      # arquivo em uma linha
attr() { sed -nE "s/.*[[:space:]]$2=[\"']([^\"']*)[\"'].*/\1/Ip; t; s/.*[[:space:]]$2=([^[:space:]>\"']+).*/\1/Ip" <<<"$1" | head -1; }
tags() { grep -oiE "<$2[^>]*>" <<<"$1"; }               # $1 = html numa linha, $2 = nome da tag

: > "$TMP/paginas.tsv"; : > "$TMP/alt.tsv"
for f in "${HTMLS[@]}"; do
  rel="${f#"$DIR"/}"
  h="$(um "$f")"
  if grep -qiE '<!--[[:space:]]*seo-ok:[[:space:]]*[^[:space:]-][^>]*-->' <<<"$h"; then
    echo "AVISO waiver $rel $(grep -oiE '<!--[[:space:]]*seo-ok:[^>]*-->' <<<"$h" | head -1)"; continue
  fi
  grep -qiE 'seo-ok:' <<<"$h" && erro waiver-sem-motivo "$rel" "seo-ok: exige motivo dentro de comentário HTML (<!-- seo-ok: motivo -->)"
  robots="$(tags "$h" meta | grep -iE 'name=["'\'']robots["'\'']' | head -1)"
  grep -qiE 'noindex' <<<"$robots" && continue            # noindex intencional: fora das regras de página

  # canonical (a tag cuja rel=canonical, em qualquer ordem de atributos)
  canon_tag="$(tags "$h" link | grep -iE 'rel=["'\'']?canonical["'\'']?([[:space:]>]|$)' | head -1)"
  canon="$(attr "$canon_tag" href)"
  if [ -z "$canon" ]; then erro canonical-ausente "$rel" "página indexável sem rel=canonical (self-canonical é piso)"
  else
    case "$canon" in
      http://*|https://*) ;;
      *) erro canonical-relativa "$rel" "canonical deve ser URL absoluta, achei '$canon'" ;;
    esac
    case "$canon" in *\?*|*utm_*) erro canonical-parametro "$rel" "canonical com parâmetro/tracking: '$canon'" ;; esac
  fi

  title="$(grep -oiE '<title[^>]*>[^<]*</title>' <<<"$h" | head -1 | sed -E 's#<[^>]*>##g; s/^[[:space:]]+//; s/[[:space:]]+$//')"
  desc_tag="$(tags "$h" meta | grep -iE 'name=["'\'']description["'\'']' | head -1)"
  desc="$(attr "$desc_tag" content | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')"
  [ -n "$title" ] || erro title-ausente "$rel" "sem <title> (ou vazio)"
  [ -n "$desc" ] || erro description-ausente "$rel" "sem meta description (ou vazia)"
  grep -qiE '<h1[ >]' <<<"$h" || erro h1-ausente "$rel" "sem <h1>"

  printf '%s\t%s\t%s\t%s\n' "$rel" "$canon" "$title" "$desc" >> "$TMP/paginas.tsv"
  # alternates hreflang: rel<TAB>canonical<TAB>hreflang<TAB>href
  while IFS= read -r lt; do
    [ -n "$lt" ] || continue
    hl="$(attr "$lt" hreflang)"; hr="$(attr "$lt" href)"
    [ -n "$hl" ] && printf '%s\t%s\t%s\t%s\n' "$rel" "$canon" "$hl" "$hr" >> "$TMP/alt.tsv"
  done < <(tags "$h" link | grep -iE 'rel=["'\'']alternate["'\'']' | grep -iE 'hreflang=')
done

# --- canonical cruzado: todo canonical no host do site -------------------------------------------
host_de() { sed -E 's#^[a-zA-Z]+://([^/:?#]+).*#\1#' <<<"$1" | tr '[:upper:]' '[:lower:]'; }
if [ -z "$HOST" ]; then
  NH="$(awk -F'\t' '$2 ~ /^https?:\/\// {print $2}' "$TMP/paginas.tsv" | sed -E 's#^[a-zA-Z]+://([^/:?#]+).*#\1#; s#^www\.##' | tr '[:upper:]' '[:lower:]' | sort -u | wc -l)"
  [ "$NH" -le 1 ] || erro host-ambiguo "-" "canonicals em $NH hosts e sem --host: não inferimos o host pela maioria (um build inteiro com canonical errado passaria). Passe --host <dominio>"
  HOST="$(awk -F'\t' '$2 ~ /^https?:\/\// {print $2}' "$TMP/paginas.tsv" | sed -E 's#^[a-zA-Z]+://([^/:?#]+).*#\1#' \
    | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -rn | awk 'NR==1{print $2}')"
fi
HOST="$(tr '[:upper:]' '[:lower:]' <<<"$HOST")"
if [ -n "$HOST" ]; then
  while IFS=$'\t' read -r rel canon _ _; do
    case "$canon" in http://*|https://*) ;; *) continue ;; esac
    ch="$(host_de "$canon")"
    ok=0; for hh in ${HOST//,/ }; do
      [ "$ch" = "$hh" ] || [ "$ch" = "www.$hh" ] || [ "www.$ch" = "$hh" ] && ok=1
    done
    [ "$ok" = 1 ] \
      || erro canonical-cruzado "$rel" "canonical em '$ch', fora do(s) host(s) do site '$HOST' (canonical cruzando domínios da casa joga fora autoridade)"
  done < "$TMP/paginas.tsv"
fi

# --- title/description únicos --------------------------------------------------------------------
dups() { # coluna regra rotulo
  awk -F'\t' -v c="$1" '$c != "" {n[$c]++; a[$c]=a[$c] " " $1} END {for (k in n) if (n[k]>1) print a[k] "\t" k}' "$TMP/paginas.tsv" \
    | LC_ALL=C sort | while IFS=$'\t' read -r arqs valor; do
        erro "$2" "${arqs# }" "$3 repetido em ${arqs# }: '${valor:0:60}'"
      done
}
D1="$(dups 3 title-duplicado title)"; [ -n "$D1" ] && { echo "$D1"; ERROS=$((ERROS+$(wc -l <<<"$D1"))); }
D2="$(dups 4 description-duplicada description)"; [ -n "$D2" ] && { echo "$D2"; ERROS=$((ERROS+$(wc -l <<<"$D2"))); }

# --- hreflang: x-default, self e recíproco -------------------------------------------------------
if [ -s "$TMP/alt.tsv" ]; then
  while IFS= read -r rel; do
    canon="$(awk -F'\t' -v r="$rel" '$1==r{print $2; exit}' "$TMP/alt.tsv")"
    awk -F'\t' -v r="$rel" '$1==r && tolower($3)=="x-default"{f=1} END{exit !f}' "$TMP/alt.tsv" \
      || erro hreflang-sem-xdefault "$rel" "conjunto hreflang sem x-default"
    [ -n "$canon" ] && { awk -F'\t' -v r="$rel" -v c="$canon" '$1==r && $4==c{f=1} END{exit !f}' "$TMP/alt.tsv" \
      || erro hreflang-sem-self "$rel" "conjunto hreflang não lista a própria URL ($canon)"; }
    # recíproco: cada alternate que é página deste site deve listar de volta esta página
    while IFS=$'\t' read -r _ _ _ href; do
      [ -n "$href" ] && [ "$href" != "$canon" ] || continue
      alvo="$(awk -F'\t' -v u="$href" '$2==u{print $1; exit}' "$TMP/paginas.tsv")"
      [ -n "$alvo" ] || continue                           # alternate fora deste build: não verificável aqui
      [ -n "$canon" ] && { awk -F'\t' -v r="$alvo" -v c="$canon" '$1==r && $4==c{f=1} END{exit !f}' "$TMP/alt.tsv" \
        || erro hreflang-sem-reciproco "$rel" "aponta $href ($alvo), que não aponta de volta para $canon"; }
    done < <(awk -F'\t' -v r="$rel" '$1==r' "$TMP/alt.tsv")
  done < <(cut -f1 "$TMP/alt.tsv" | LC_ALL=C sort -u)
fi

# --- hreflang entre CONTEÚDOS DISTINTOS (domínios da casa) ---------------------------------------
# hreflang serve a tradução 1:1 do MESMO conteúdo. Alternate em host diferente do canonical só passa se
# AMBAS as páginas declaram o mesmo `<!-- seo-variant: slug -->` (= mesmo conteúdo, traduzido). Sem
# marcador, ou com slugs diferentes, é hreflang entre conteúdos distintos: reprova.
variante() { grep -oiE 'seo-variant:[[:space:]]*[A-Za-z0-9_./-]+' "$TMP/v_$(tr '/' '_' <<<"$1").txt" 2>/dev/null | head -1 | sed -E 's/.*:[[:space:]]*//'; }
for f in "${HTMLS[@]}"; do rel="${f#"$DIR"/}"; um "$f" > "$TMP/v_$(tr '/' '_' <<<"$rel").txt"; done
if [ -s "$TMP/alt.tsv" ]; then
  while IFS=$'\t' read -r rel canon hl href; do
    case "$canon" in http*) ;; *) continue ;; esac
    case "$href" in http*) ;; *) continue ;; esac
    [ "$(host_de "$href" | sed 's/^www\.//')" != "$(host_de "$canon" | sed 's/^www\.//')" ] || continue
    va="$(variante "$rel")"
    alvo="$(awk -F'\t' -v u="$href" '$2==u{print $1; exit}' "$TMP/paginas.tsv")"
    vb=""; [ -n "$alvo" ] && vb="$(variante "$alvo")"
    if [ -z "$va" ]; then erro hreflang-conteudo-distinto "$rel" "hreflang para outro domínio ($href) sem 'seo-variant: <slug>': hreflang só liga tradução 1:1 do MESMO conteúdo; conteúdo distinto liga por link, sem hreflang"
    elif [ -n "$alvo" ] && [ "$va" != "$vb" ]; then erro hreflang-conteudo-distinto "$rel" "hreflang para $href ($alvo), mas variante '$va' != '${vb:-ausente}': conteúdo distinto não leva hreflang"
    fi
  done < "$TMP/alt.tsv"
fi

# --- robots.txt e sitemap.xml --------------------------------------------------------------------
if [ -f "$DIR/robots.txt" ]; then
  # `User-agent: *` seguido de `Disallow: /` (sozinho) bloqueia o site inteiro
  awk '{l=tolower($0)} l ~ /^[[:space:]]*user-agent:/ {ua=(l ~ /\*/)} ua && l ~ /^[[:space:]]*disallow:[[:space:]]*\/[[:space:]]*(#.*)?$/ {f=1} END{exit !f}' "$DIR/robots.txt" \
    && erro robots-bloqueia-tudo robots.txt "User-agent: * com 'Disallow: /' tira o site inteiro do índice (staging deve ser noindex/auth, não vazar para prd)"
  grep -qiE '^[[:space:]]*sitemap:[[:space:]]*https?://' "$DIR/robots.txt" \
    || erro robots-sem-sitemap robots.txt "robots.txt sem linha 'Sitemap: https://...'"
else
  erro robots-ausente robots.txt "sem robots.txt na raiz do build"
fi
if [ ! -f "$DIR/sitemap.xml" ] && ! ls "$DIR"/sitemap*.xml >/dev/null 2>&1; then
  erro sitemap-ausente sitemap.xml "sem sitemap.xml (autogerado, nunca à mão) na raiz do build"
else
  for sm in "$DIR"/sitemap*.xml; do
    grep -qiE '<loc>[[:space:]]*https?://[^<]+</loc>' "$sm" || erro sitemap-sem-loc "${sm#"$DIR"/}" "sitemap sem nenhum <loc> com URL absoluta (existir não basta)"
  done
fi

if [ "$ERROS" -gt 0 ]; then echo "check-seo: REPROVADO — $ERROS achado(s) em ${#HTMLS[@]} página(s)"; exit 1; fi
echo "check-seo: ok — ${#HTMLS[@]} página(s), host $HOST"
