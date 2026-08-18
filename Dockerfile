# =============================================================================
# Obraz aplikacji testowej OWASP Juice Shop z kontrolowanie wprowadzonymi
# defektami klasy CNT (skanowanie obrazow kontenerowych).
#
# Aplikacja budowana jest wylacznie tutaj - potok nie powtarza kompilacji
# w osobnym zadaniu.
#
# Dobor obrazu bazowego stanowi kompromis miedzy realizmem defektu a sprawnoscia
# aplikacji. Srodowisko uruchomieniowe musi pozostac na tyle aktualne, aby
# aplikacja sie zbudowala i uruchomila, poniewaz w przeciwnym razie niemozliwe
# byloby przeprowadzenie testowania dynamicznego (faza 6) oraz wdrozenia.
# Z tego wzgledu przestarzalosc realizowana jest przez dystrybucje bazowa,
# a nie przez wersje srodowiska Node.
#
# Defekty wprowadzone w tym pliku: CNT-01, CNT-02, CNT-03, CNT-04, CNT-05
# Wykaz pelny: zalacznik A pracy.
# =============================================================================

# -----------------------------------------------------------------------------
# CNT-01 | CWE-1104 | faza 5
#   Przestarzala dystrybucja bazowa: Debian bullseye to wydanie poprzedniej
#   generacji, zawierajace znane podatnosci pakietow systemowych.
#
# CNT-05 | CWE-1357 | faza 5
#   Brak przypiecia obrazu bazowego do skrotu warstwy - odwolanie przez znacznik,
#   ktory jest wskaznikiem zmiennym. Postac zalecana: node:22-bullseye@sha256:...
# -----------------------------------------------------------------------------
  FROM node:22-bullseye

  WORKDIR /juice-shop
  
  # -----------------------------------------------------------------------------
  # CNT-02 | CWE-1395 | faza 5
  #   Pakiety systemowe o znanych podatnosciach, instalowane bez potrzeby
  #   funkcjonalnej. Aplikacja nie wymaga ani curl, ani wget do dzialania.
  # -----------------------------------------------------------------------------
  RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           curl \
           wget \
      && rm -rf /var/lib/apt/lists/*
  
  # -----------------------------------------------------------------------------
  # Zaleznosci narzedziowe wymagane przez proces budowania aplikacji testowej.
  # -----------------------------------------------------------------------------
  RUN npm install -g typescript ts-node
  
  # -----------------------------------------------------------------------------
  # Instalacja zaleznosci i budowanie aplikacji.
  # Przelacznik --unsafe-perm jest wymagany, poniewaz proces budowania uruchamiany
  # jest z uprawnieniami uzytkownika uprzywilejowanego (patrz CNT-04).
  # -----------------------------------------------------------------------------
  COPY package*.json ./
  RUN npm install --omit=dev --unsafe-perm --no-audit --no-fund
  
  COPY . .
  RUN npm run build
  
  # -----------------------------------------------------------------------------
  # CNT-03 | CWE-1395 | faza 5
  #   Zaleznosc jezykowa o znanej podatnosci, obecna wylacznie w obrazie wynikowym.
  #   Przelacznik --no-save powoduje, ze pakiet nie pojawia sie w pliku manifestu
  #   repozytorium, a zatem nie zostanie wykryty przez analize kompozycji
  #   oprogramowania - wylacznie przez skanowanie obrazu.
  # -----------------------------------------------------------------------------
  RUN npm install lodash@4.17.15 --no-save --no-audit --no-fund
  
  # -----------------------------------------------------------------------------
  # Porzadkowanie katalogow tymczasowych aplikacji testowej.
  # -----------------------------------------------------------------------------
  RUN mkdir -p /juice-shop/logs /juice-shop/ftp \
      && chmod -R 755 /juice-shop/logs /juice-shop/ftp
  
  EXPOSE 3000
  
  ENV NODE_ENV=production
  
  # -----------------------------------------------------------------------------
  # CNT-04 | CWE-250 | faza 5
  #   Brak instrukcji USER - proces aplikacji dziala z uprawnieniami uzytkownika
  #   uprzywilejowanego. Postac zalecana: USER node przed instrukcja CMD.
  # -----------------------------------------------------------------------------
  CMD ["npm", "start"]