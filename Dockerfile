# DEFEKTY CNT-01, CNT-02, CNT-03, CNT-04, CNT-05 | oczekiwana faza 5
# CNT-01 | CWE-1104: przestarzaly obraz bazowy
# CNT-05 | CWE-1357: brak przypiecia do skrotu warstwy (tag zamiast digest)
FROM node:14-buster

WORKDIR /opt/juice-shop
# CNT-02 | CWE-1395: pakiety systemowe o znanych podatnosciach
RUN apt-get update && apt-get install -y --no-install-recommends \
      curl=7.64.0-4+deb10u1 || apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm ci --omit=dev
# CNT-03 | CWE-1395: zaleznosc jezykowa instalowana wylacznie w obrazie
RUN npm install lodash@4.17.15 --no-save

COPY . .
EXPOSE 3000
# CNT-04 | CWE-250: brak instrukcji USER - proces dziala jako root
CMD ["npm", "start"]
