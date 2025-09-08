#!/bin/bash

# Sprawdzamy, czy podano URL jako argument
if [ -z "$1" ]; then
  echo "Błąd: Musisz podać URL jako parametr."
  echo "Użycie: $0 <URL>"
  exit 1
fi

# Parametr URL
URL=$1

echo "Aktualizuje system"
sudo apt update && sudo apt upgrade -y

if ! command -v unclutter &> /dev/null; then
  echo "Instaluję unclutter..."
  sudo apt install -y unclutter
else
  echo "Unclutter już jest zainstalowany."
fi

if ! command -v teamviewer &> /dev/null; then
  echo "Instaluję teamviewer..."
  curl -L -o /tmp/teamviewer-host_arm64.deb https://download.teamviewer.com/download/linux/teamviewer-host_arm64.deb
  sudo apt install -y -o Dpkg::Options::="--force-confold" /tmp/teamviewer-host_arm64.deb || sudo apt --fix-broken install -y
  rm /tmp/teamviewer-host_arm64.deb
  sudo systemctl enable teamviewerd
  sudo systemctl start teamviewerd
else
  echo "Teamviewer już jest zainstalowany."
fi

echo "Dodaję wpisy do crontaba..."
(crontab -l ; echo "0 8 * * * sudo reboot") | sort - | uniq - | crontab -
(crontab -l ; echo "30 7 * * * xrandr --output HDMI-1 --transform 270 --auto || xrandr --output HDMI-2 --transform 270 --auto") | sort - | uniq - | crontab -
(crontab -l ; echo "0 20 * * * xrandr --output HDMI-1 --off || xrandr --output HDMI-2 --off") | sort - | uniq - | crontab -

# Folder autostartu (jeśli nie istnieje, tworzony jest)
AUTOSTART_DIR="$HOME/.config/autostart"
mkdir -p "$AUTOSTART_DIR"

# Plik .desktop
DESKTOP_FILE="$AUTOSTART_DIR/startup.desktop"

# Tworzenie pliku .desktop
echo "[Desktop Entry]" > "$DESKTOP_FILE"
echo "Type=Application" >> "$DESKTOP_FILE"
echo "Name=Firefox Kiosk" >> "$DESKTOP_FILE"
echo "Exec=$HOME/boot.sh $URL" >> "$DESKTOP_FILE"
echo "X-GNOME-Autostart-enabled=true" >> "$DESKTOP_FILE"
echo "NoDisplay=false" >> "$DESKTOP_FILE"
echo "Comment=Uruchamia Firefox w trybie kiosku na podanym URL" >> "$DESKTOP_FILE"

# Nadanie odpowiednich uprawnień do pliku
chmod +x "$DESKTOP_FILE"

echo "Plik .desktop został utworzony i zapisany w: $DESKTOP_FILE"

STARTUP_FILE="$HOME/boot.sh"

rm -f $STARTUP_FILE

if ! grep -q "wlr-randr --output HDMI-A-1 --transform 270" "$STARTUP_FILE"; then
  echo "#!/bin/bash" > "$STARTUP_FILE"
  echo "sleep 5"
  echo "URL=$1" >> "$STARTUP_FILE"
  echo "wlr-randr --output HDMI-A-1 --transform 270" >> "$STARTUP_FILE"
  echo "wlr-randr --output HDMI-A-2 --transform 270" >> "$STARTUP_FILE"
  echo "xrandr --output HDMI-1 --rotate right" >> "$STARTUP_FILE"
  echo "xrandr --output HDMI-2 --rotate right" >> "$STARTUP_FILE"
  echo "firefox --kiosk $URL" >> "$STARTUP_FILE"
fi

chmod +x "$STARTUP_FILE"

rm ~/install.sh

read -p "Czy chcesz zrestartować komputer? (t/n): " response
if [[ "$response" =~ ^[Tt]$ ]]; then
  reboot
else
  echo "Restart został anulowany."
fi
