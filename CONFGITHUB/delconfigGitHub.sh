#!/bin/bash

# Definición de colores (necesarios para los echo de abajo)
ROJO='\033[0;31m'
VERDE='\033[0;32m'
NC='\033[0m'

echo -e "${ROJO}🗑️ Borrando configuración global de Git...${NC}"
    
# 1. Borrar el archivo de configuración global (nombre, email y helper)
rm -f ~/.gitconfig
    
# 2. Borrar el archivo donde se guardan los Tokens físicamente
rm -f ~/.git-credentials
    
# 3. Limpiar la caché de credenciales de la sesión actual
git credential-cache exit 2>/dev/null

# 4. Limpiar cualquier configuración de sistema (por si acaso)
git config --global --unset-all user.name 2>/dev/null
git config --global --unset-all user.email 2>/dev/null
git config --global --unset-all credential.helper 2>/dev/null
    
echo -e "${VERDE}✨ Sistema limpio. Ahora puedes probar tu script como si fuera la primera vez.${NC}"
