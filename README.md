## Guia de Instalação para o Mangowm no Biglinux/Archlinux/manjaro Ou quaquer base archlinux

-   AUTHOR_____:   Elizeu Marino
-   DATA_______:   2026
-   VERSÃO 1.0.0


** dica para pesquisar https://github.com/victorsosaMx/vsWaybar-Studio **

### opcionais dependencias que podem ser necessarias na config com waybar 
** sudo paru -S kvantum kvantum-qt5 kvantum-qt6-git kvantummanager qt5ct qt6ct nwg-look arc-gtk-theme breeze-icons adw-gtk-theme **

## https://github.com/mangowm/mango

sudo pacman -S noto-fonts ttf-dejavu ttf-liberation noto-fonts-emoji noto-fonts-extra noto-fonts-cjk ttf-liberation otf-font-awesome ttf-jetbrains-mono ttf-jetbrains-mono-nerd

- sudo pacman -S --needed base-devel
- git clone https://aur.archlinux.org/paru.git
- cd paru
- makepkg -si


### Dependencies principais do mango
paru -S rofi foot xdg-desktop-portal-wlr swaybg waybar wl-clip-persist cliphist wl-clipboard wlsunset xfce-polkit swaync pamixer wlr-dpms sway-audio-idle-inhibit-git swayidle dimland-git brightnessctl swayosd wlr-randr grim slurp satty swaylock-effects-git wlogout sox mango-git

### Dependencies DMS
paru -S foot xdg-desktop-portal-wlr swaybg wl-clip-persist cliphist wl-clipboard sway-audio-idle-inhibit-git brightnessctl grim slurp satty matugen-bin dms-shell-git quickshell-git

### Config DMS
git clone -b dms https://github.com/DreamMaoMao/mango-config.git ~/.config/mango

### Config Waybar
git clone https://github.com/DreamMaoMao/mango-config.git ~/.config/mango


### 1. Configuração de teclado para ABNT2
Usando o localectl
Como o MangoWC utiliza a biblioteca libxkbcommon, 
ele pode herdar as configurações do sistema definidas pelo 
systemd/localectl. 
Execute:
bash
localectl set-x11-keymap br abnt2 abnt2

### 2. Configurar arquivo config.conf do mangowm
No arquivo de configuração (config.conf) 
O MangoWC é um compositor Wayland baseado no dwl (que por sua vez é inspirado no dwm). Ao contrário de compositores como o Sway ou Hyprland, 
As versões mais recentes do MangoWC permitem configurar variáveis de ambiente e parâmetros de entrada diretamente no arquivo de configuração (geralmente em ~/.config/mango/config.conf). Tente adicionar as seguintes linhas:

### Configurações de Teclado no mango.conf
xkb_rules_layout=br
xkb_rules_variant=abnt2
xkb_rules_model=pc105
xkb_rules_options=grp:alt_altgr_toggle,caps:hyper

### Opcional: Ajuste de repetição de teclas
repeat_rate=25
repeat_delay=600

### 3. configurar arquivo .bash_profile
Variáveis de Ambiente Globais
Se a opção acima não funcionar, você deve definir as variáveis de 
ambiente antes de iniciar o MangoWC. 
Adicione estas linhas ao seu arquivo 
~/.bash_profile,
~/.zprofile ou 
/etc/environment:

> ### Configuração de teclado para Mangowm
> export XKB_DEFAULT_LAYOUT=br
> export XKB_DEFAULT_VARIANT=abnt2
> export XKB_DEFAULT_MODEL=abnt2
