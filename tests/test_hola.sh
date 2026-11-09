#!/usr/bin/env bash
# Pruebas unitarias de app/hola.sh
set -u
source "$(dirname "$0")/../app/hola.sh"

fallos=0
probar() {
  local esperado="$1"; shift
  local obtenido
  obtenido="$(saludar "$@")"
  if [[ "$obtenido" == "$esperado" ]]; then
    echo "PASS: saludar $* -> $obtenido"
  else
    echo "FAIL: saludar $* -> '$obtenido' (esperado: '$esperado')"
    fallos=$((fallos + 1))
  fi
}

probar "Hola, Mundo!"
probar "Hola, Jenkins!" "Jenkins"
probar "Hola, DevSecOps!" "DevSecOps"

if [[ $fallos -eq 0 ]]; then
  echo "Todas las pruebas pasaron"
else
  echo "$fallos prueba(s) fallaron"
  exit 1
fi
