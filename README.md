# Instrukcja

## Przygotowanie

Przy instalacji Raspberry Pi OS należy wybrać przeglądarkę Firefox.
> Raspberry Pi OS (64-bit), port of Debian Bookworm, Released: 2024-11-19

> [!IMPORTANT]
> Przed instalacją systemu na płytce należy wpiąć kamerę.

## Krok 1

Uruchom przeglądarkę Firefox i przejdź pod adres URL który będzie uruchamiany na komputerze, następnie zaakceptuj prośbę o dostęp do kamery komputera. 

> [!NOTE]
> Powinny wyskoczyć dwa zapytania o uprawnienia do kamery: jedno systemowe i jedno z przeglądarki - zaznaczyć checkbox "Remember for all camera".

## Krok 2

Wykonaj w shellu następującą komendę (podmienić https://example.com na adres który potrzebujemy mieć uruchamiany przy starcie):

```
curl -O https://raw.githubusercontent.com/jakubchmielewski-loca/raspberry-pi/main/install.sh && \n
chmod +x install.sh && \n
./install.sh https://example.com
```
