FROM python:3.10

WORKDIR /app

COPY . .

RUN pip3 install -r requirements.txt

ENV DATABASE_URL="mongodb://mongo:27017"

EXPOSE 8000

CMD ["python3", "main.py"]

# LABORATORIUM 1 - PODSTAWY KONTENERYZACJI: DOCKER I DOCKER COMPOSE

# 3.0 - Hello world w Dockerfile
# Aby używać bazę danych MongoDB na wybranym procesorze, musiałem obniżyć jej wersję z "latest" na "4.4.6": docker pull mongo:4.4.6
# Wszystko działało poprawnie, więc proces przeprowadzono pomyślnie.

# 3.5 - Otworzenie aplikacji na świat
# Przejście do katalogu, w którym znajduje się plik Dockerfile: cd projekt_do_pracy_na_labach/fiszki_backend
# Zbudowanie obrazu kontenera: docker build --tag fiszki_backend .
# Uruchomienie kontenera: docker run -p 8000:8000 --name fiszki_backend fiszki_backend
# W przeglądarce wyświetliła się strona zatytuowana "Devops labs api", więc proces przeprowadzono pomyślnie.

# 4.0 - Połączenie aplikacji back-endowej z bazą danych
# Utworzenie sieci pomiędzy kontenerami: docker network create siec
# Zbudowanie obrazu kontenera: docker build --tag fiszki_be .
# Uruchomienie kontenera w utworzonej sieci: docker run -p 8000:8000 --network=siec --name fiszki_be fiszki_be
# Uruchomienie bazy danych mongodb w utworzonej sieci: docker run -p 27017:27017 --network=siec --name mongodb mongo:4.4.6
# Monitorowanie sieci: docker network inspect siec
# Sieć łącząca aplikację back-endową z bazą danych została stworzona pomyślnie - informacje o tym wyświetlone zostały w terminalu.

# 4.5 - Dodanie wolumenów do Dockerfile'a z bazą danych
# Utworzenie wolumenu: docker volume create wolumen
# Zamontowanie wolumenu z hosta do kontenera: docker run -p 8000:8000 -v wolumen:/app --name fiszki_be fiszki_be
# Uruchomienie kontenera z bazą danych razem z wolumenem: docker run -p 27017:27017 -v wolumen:/app --name mongodb mongo:4.4.6
# Weryfikacja poprawności działania stworzonego wolumenu:
# docker exec -it fiszki_be bash
# echo "Dane testowe" > /app/plik_testowy.txt
# exit
# docker rm -f fiszki_be
# docker run -d --name fiszki_be_v2 -v wolumen:/app fiszki_backend
# docker exec -it fiszki_be_v2 bash
# cat /app/plik_testowy.txt
# Wyświetlenie w terminalu zawartości pliku plik_testowy.txt, czyli treści "Dane testowe", oznacza, że wolumen działa poprawnie.
# exit

# 5.0 - Docker-compose jako dodatek
# [Brak realizacji]