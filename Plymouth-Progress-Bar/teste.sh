#!/bin/bash

# Verifica se o Plymouth está instalado
if ! command -v plymouth &>/dev/null; then
    echo "Plymouth não está instalado. Instale-o antes de executar este script."
    exit 1
fi

# Lista os temas disponíveis
echo "Temas disponíveis:"
sudo plymouth-set-default-theme --list

# Define um tema para teste
echo "Digite o nome do tema que deseja testar (ou pressione Enter para manter o padrão):"
read -r TEMA

if [ -n "$TEMA" ]; then
    echo "Definindo o tema para: $TEMA"
    sudo plymouth-set-default-theme "$TEMA"
else
    echo "Mantendo o tema padrão."
fi

# Testa o tema configurado
echo "Iniciando teste do Plymouth. Pressione Ctrl+C para sair."
sudo plymouthd --debug-file=./plymouthd.log --pid-file=./plymouthd.pid
sudo plymouth change-mode --boot-up
sudo plymouth --show-splash 
    sleep 5
sudo plymouth display-message --text "Iniciando teste do Plymouth. Pressione Ctrl+C para sair."
    sleep 2
sudo plymouth change-mode --updates
sudo plymouth display-message --text "Teste de Atualização encontrada... (2 segundos)"
    sleep 2
for i in $(seq 1 5); do
    sudo plymouth --update=testando_$i
    sudo plymouth system-update --progress $i
    sudo plymouth display-message --text "Mensagem de Update - $i%"
    sleep 1
done
sudo plymouth change-mode --boot-up
sudo plymouth display-message --text "Continuando boot..."
sleep 3
sudo plymouth display-message --text ""
sleep 5

sudo plymouth ask-for-password

sudo plymouth change-mode --reboot
sudo plymouth display-message --text "Teste de --reboot... (2 segundos)"
    sleep 2

sudo plymouth change-mode --shutdown
sudo plymouth display-message --text "Teste de --shutdown... (2 segundos)"
    sleep 2

sudo plymouth --quit
echo "Teste do Plymouth finalizado."
