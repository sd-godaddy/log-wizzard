

_SHELL="$(ps "${$}" | grep "${$} " | grep -v grep | sed -rn "s/.*[-\/]+(bash|z?sh) .*/\1/p")"; # bash || sh || zsh
case ${_SHELL} in
  zsh)
    _DIR="$( cd "$( dirname "${(%):-%N}" )" && pwd -P )"
    ;;
  sh)
    _DIR="$( cd "$( dirname "${0}" )" && pwd -P )"
    ;;
  *)
    _DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"
    ;;
esac

ROOT="${_DIR}/.."

cd "${ROOT}"

set -e
set -x

echo "{}" > package.json

yarn add showdown

ls -la

set -x

node node_modules/.bin/showdown --help

node node_modules/.bin/showdown makehtml --help

node node_modules/.bin/showdown makehtml -i README.md -o index-raw.html

awk 'FNR==NR {B = B $0 ORS; next} /%%/ {sub("%%", B)} 1' index-raw.html .github/showdown.html > index.html

rm -rf index-raw.html

ls -la

ls -la .github/

