#!/bin/bash

echo "== Seguridad básica en Linux =="

# 1. Crear un usuario con shell limitado (sin preguntas interactivas)
read -p "Ingrese el nombre del nuevo usuario seguro: " usuario
sudo useradd -m -s /usr/sbin/nologin $usuario
echo "Usuario '$usuario' creado con shell restringido."
sudo passwd $usuario

# 2. Crear carpeta protegida
sudo mkdir /seguridad
sudo chown root:root /seguridad
sudo chmod 700 /seguridad
echo "Carpeta /seguridad creada con acceso exclusivo para root."

# 3. Configurar firewall básico (ufw)
echo "Activando el firewall y bloqueando el puerto 23 (telnet)..."
sudo ufw allow ssh
sudo ufw deny 23
sudo ufw enable
sudo ufw status verbose

# 4. Desactivar servicio innecesario (bluetooth)
echo "Desactivando servicio innecesario (bluetooth)..."
sudo systemctl disable bluetooth 2>/dev/null || echo "Servicio bluetooth no disponible en este entorno."

# 5. Mostrar intentos de acceso fallidos
echo "Mostrando últimos intentos de acceso fallidos:"
sudo grep "Failed password" /var/log/auth.log | tail -n 5

echo "== Proceso de configuración finalizado =="
