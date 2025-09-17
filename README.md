# Instrukcja

## Przygotowanie

Przy instalacji Raspberry Pi OS należy wybrać przeglądarkę Firefox.

> Raspberry Pi OS (64-bit), port of Debian Bookworm, Released: 2025-05-13

> [!IMPORTANT]
> Przed instalacją systemu na płytce należy wpiąć kamerę. HDMI powinno być w porce oznaczonym HDMI0

## Krok 1

Uruchom przeglądarkę Firefox i przejdź pod adres about:config, zaakceptuj ryzyko, następnie wpisz w wyszukiwarkę "permissions.default.camera" i zmień wartość tej opcji z 0 na 1, zatwierdź przyciskiem po prawej.

## Krok 2

Wykonaj w shellu następującą komendę (podmienić https://example.com na adres który potrzebujemy mieć uruchamiany przy starcie):

```
curl -O https://raw.githubusercontent.com/jakubchmielewski-loca/raspberry-pi/main/install.sh && \
chmod +x install.sh && \
./install.sh https://example.com
```

## Krok 3

Możliwe że po reboocie wyskoczy jeszcze prompt systemowy czy pozwolić na korzystanie z kamery firefoxowi - zezwolić

# TODO

- [x] dodać wyłączenie powiadomień
- [x] wyłączyć wygaszanie ekranu
