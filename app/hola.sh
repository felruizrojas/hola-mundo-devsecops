#!/usr/bin/env bash
# Aplicación "Hola Mundo" - Actividad DevSecOps (OCY1102)

saludar() {
  local nombre="${1:-Mundo}"
  echo "Hola, ${nombre}!"
}

# Solo se ejecuta si el script se llama directamente (no al importarlo en las pruebas)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  saludar "$@"
fi
