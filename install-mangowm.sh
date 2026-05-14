#!/bin/bash

#----------------------------------------------------------------------
#   Script de Instalação Moderno em Bash Puro (Sem dependências)
#   @AUTHOR_____: Elizeu Marino 
#   @VERSÃO_____: 4.0.0 (Totalmente Nativo)
#----------------------------------------------------------------------

# Definição de cores ANSI para o terminal
VERDE="\e[1;32m"
AZUL="\e[1;34m"
CIANO="\e[1;36m"
AMARELO="\e[1;33m"
RESET="\e[0m"

# Altera o texto do prompt nativo do comando 'select'
PS3=$(echo -e "\n${AZUL}Digite o número da sua opção e aperte [Enter]: ${RESET}")

clear

menu() {
    echo -e "${CIANO}======================================================${RESET}"
    echo -e " "
    echo -e "${VERDE}        🔧 INSTALADOR DE PACOTES MANGOWM 🔧           ${RESET}"
    echo -e " "
    echo -e "${CIANO}======================================================${RESET}"
    echo -e " Selecione o software para instalar:\n"

    # Criando o menu interativo com o 'select' nativo do Bash
    options=(
        "Instalar Dependencia Obrigatoria"
        "Instalar Mangowm com DMS"
        "Instalar Mangowm com Waybar"
        "Instalar Opcionais da Waybar"
        "Definir Teclado para Portugues Brazil"
        "Sair"
    )

    select opt in "${options[@]}"
    do
        case $REPLY in
            1) inst_obrigas ;;
            2) inst_dms ;;
            3) inst_waybar ;;
            4) inst_opcions ;;
            5) def_brazil ;; # CORRIGIDO: Modificado hífen para sublinhado para bater com a função
            6|[sS]|[sS][aA][iI][rR]) sair ;;
            *) 
                echo -e "${AMARELO}Opção inválida! Escolha de 1 a 6.${RESET}"
                sleep 1.5
                clear
                menu
                ;;
        esac
    done
}

function inst_obrigas(){
    clear
    echo -e " "
    echo -e "${AZUL}Instalando Dependencias Obrigatorias...${RESET}"
    echo -e " "
    mkdir -p ~/temp
    cd ~/temp || exit
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/paru.git
    cd paru || exit
    makepkg -si --noconfirm
    sudo pacman -Syu --noconfirm noto-fonts ttf-dejavu ttf-liberation noto-fonts-emoji noto-fonts-extra noto-fonts-cjk otf-font-awesome ttf-jetbrains-mono ttf-jetbrains-mono-nerd
    paru -S --noconfirm rofi foot xdg-desktop-portal-wlr swaybg waybar wl-clip-persist cliphist wl-clipboard wlsunset xfce-polkit swaync pamixer wlr-dpms sway-audio-idle-inhibit-git swayidle dimland-git brightnessctl swayosd wlr-randr grim slurp satty swaylock-effects-git wlogout sox mango-git
    echo " "
    echo " "    
    echo -e "${VERDE}Instalação concluída!${RESET}"
    sleep 5
    clear
    menu
}

function inst_dms(){
    clear
    echo -e " "
    echo -e "${AZUL}Instalando Mangowm com DMS...${RESET}"
    echo -e " "

    paru -S --noconfirm foot xdg-desktop-portal-wlr swaybg wl-clip-persist cliphist wl-clipboard sway-audio-idle-inhibit-git brightnessctl grim slurp satty matugen-bin dms-shell-git quickshell-git

    # Garante a pasta pai antes de qualquer operação (Boa prática)
    mkdir -p ~/.config/mango
    git clone -b dms https://github.com/DreamMaoMao/mango-config.git ~/.config/mango

    sudo mv /etc/xdg/autostart/xfce-polkit.desktop ~/.config/mango
    sudo chown "$USER:$USER" ~/.config/mango/xfce-polkit.desktop
    chmod +x ~/.config/mango/xfce-polkit.desktop
    echo '~/.config/mango/xfce-polkit.desktop &' >> ~/.config/autostart.sh
    echo " "
    echo " "
    echo -e "${VERDE}Instalação concluída!${RESET}"
    sleep 5
    clear
    menu
}

function inst_waybar(){
    clear
    echo -e " "
    echo -e "${AZUL}Instalando Mangowm com Waybar...${RESET}"
    echo -e " "
    # Garante a pasta pai antes de qualquer operação (Boa prática)
    mkdir -p ~/.config/mango

    git clone https://github.com/DreamMaoMao/mango-config.git ~/.config/mango
    sudo mv /etc/xdg/autostart/xfce-polkit.desktop ~/.config/mango
    sudo chown "$USER:$USER" ~/.config/mango/xfce-polkit.desktop
    chmod +x ~/.config/mango/xfce-polkit.desktop

    echo '~/.config/mango/xfce-polkit.desktop &' >> ~/.config/autostart.sh
    echo " "
    echo " "
    echo -e "${VERDE}Instalação concluída!${RESET}"
    sleep 5
    clear
    menu
}

function inst_opcions(){
    clear
    echo -e " "
    echo -e "${AZUL}Instalando Opcionais da Waybar...${RESET}"
    echo -e " "
    paru -S --noconfirm kvantum kvantum-qt5 kvantum-qt6-git kvantummanager qt5ct qt6ct nwg-look arc-gtk-theme breeze-icons adw-gtk-theme
    echo " "
    echo " "
    echo -e "${VERDE}Instalação concluída!${RESET}"
    sleep 5
    clear
    menu
}

function def_brazil(){
    clear
    echo -e " "
    echo -e "${AZUL}Definindo teclado para portugues Brazil...${RESET}"
    echo -e " "
    sudo localectl set-x11-keymap br abnt2 abnt2
    mkdir -p ~/.config/mango/

# CORRIGIDO: Blocos EOF abaixo alinhados à esquerda para não injetar espaços indesejados nas configurações
cat << 'EOF' >> ~/.config/mango/config.conf

### Configurações de Teclado no mango.conf
xkb_rules_layout=br
xkb_rules_variant=abnt2
xkb_rules_model=pc105
xkb_rules_options=grp:alt_altgr_toggle,caps:hyper

### Opcional: Ajuste de repetição de teclas
# repeat_rate=25
# repeat_delay=600
EOF

cat << 'EOF' >> ~/.bash_profile

### Configuração de teclado para Mangowm
export XKB_DEFAULT_LAYOUT=br
export XKB_DEFAULT_VARIANT=abnt2
export XKB_DEFAULT_MODEL=abnt2
EOF
# Fim dos Blocos EOF 

    echo " "
    echo " "
    echo -e "${VERDE}Instalação concluída!${RESET}"
    sleep 5
    clear
    menu
}

function sair(){
    clear
    echo -e "${CIANO}======================================================${RESET}"
    echo -e " "
    echo -e "${AMARELO}      Mas já está indo?${RESET}"
    echo -e "${VERDE}      Fica mais um pouco, Vai ter Bolo! \\o/${RESET}"
    echo -e " "
    echo -e "${CIANO}======================================================${RESET}"
    sleep 10
    clear
    exit 0
}

# Inicia o script chamando a função principal
menu

