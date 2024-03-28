# Laboratorium 1 - Konteneryzacja

## Wstęp
Zanim zapoznacie się z narzędziami takimi jak Kubernetes, dobrze by było poznać podstawy. I tu wkracza docker.

## Docker i konteneryzacja
<div style="text-align: justify"> 
Docker to narzędzie open-source stworzone do automatyzacji procesu wdrażania aplikacji jako lekkie, przenośne kontenery, które mogą działać na dowolnym systemie z Dockerem. Umożliwiają programistom pakowanie aplikacji wraz z ich środowiskami i zależnościami w standardowy format, co ułatwia szybkie i spójne wdrażanie oprogramowania na różnych systemach operacyjnych i platformach.

Różnica między kontenerami a maszynami wirtualnymi (VM) polega głównie na ich architekturze i wydajności. Maszyny wirtualne zawierają pełny obraz systemu operacyjnego, jądro systemu oraz aplikacje, co sprawia, że są dość ciężkie i wymagają znacznych zasobów systemowych. Każda VM działa na wirtualizowanym sprzęcie przez hipernadzorcę, co dodatkowo obciąża system.

Kontenery, takie jak te używane przez Docker, działają inaczej. Dzielą one system operacyjny hosta, ale każdy z nich działa jako odizolowany proces w przestrzeni użytkownika. To sprawia, że są znacznie lżejsze niż VM, ponieważ nie muszą wirtualizować sprzętu ani ładować całego systemu operacyjnego, co przekłada się na mniejsze zużycie zasobów i szybsze uruchamianie aplikacji.
</div>

![cos](./images/containers-vs-virtual-machines.jpg)

### Przykładowy dockerfile 


```
# wybranie obrazu z repozytorium dockera
FROM nginx:latest

# Usuń domyślną stronę Nginx
RUN rm /usr/share/nginx/html/*

# Kopiuj statyczne pliki strony internetowej do katalogu serwera Nginx
COPY ./static /usr/share/nginx/html

# Opcjonalnie: Otwórz port 80 dla ruchu HTTP
EXPOSE 80

# Przy starcie kontenera wykonaj tą komendę 
CMD ["nginx", "-g", "daemon off;"]
```
<div style="text-align: justify"> 
`FROM nginx:latest`- to dyrektywa określa bazowy obraz, od którego rozpoczyna się budowa. nginx jest to serwer WWW.

`CMD ["nginx", "-g", "daemon off;"]` - to dyrektywa definiuje domyślną komendę, która zostanie uruchomiona po starcie kontenera. W tym przypadku startuje server nginx'a z flagą 'dameon off'".
</div>

### Opcje Dockerfile'a

- `FROM` - określa obraz bazowy. Jest to pierwsza instrukcja w każdym Dockerfile. Możesz używać obrazów z Docker Hub lub prywatnych repozytoriów.

- `CMD` - podaje domyślną komendę, która ma być wykonana podczas uruchomienia kontenera. Może być zastąpiona przez argumenty podane podczas uruchamiania kontenera z docker run.

- `RUN` - wykonuje polecenia w nowej warstwie na wierzchu bieżącego obrazu i zatwierdza wynik. Służy do instalacji pakietów lub konfiguracji w obrazie.
- `ENV` - ustawia zmienną środowiskową. Może być używana przez procesy uruchomione w kontenerze.
 
- `EXPOSE` - informuje Dockera, że kontener nasłuchuje na określonych portach w trakcie działania. To jednak tylko deklaracja, do publikacji portu służy opcja -p w docker run.

- `COPY `- kopiuje pliki i katalogi z kontekstu budowy do systemu plików kontenera.
 
- `ADD `- podobnie jak COPY, ale dodatkowo może pobierać zdalne pliki URL i rozpakowywać archiwa.
 
- `ENTRYPOINT` - pozwala skonfigurować kontener do uruchamiania jako wykonywalny. CMD można używać razem z ENTRYPOINT do określenia domyślnych argumentów.

- `WORKDIR` - ustawia katalog roboczy dla instrukcji RUN, CMD, ENTRYPOINT, COPY i ADD.

- `USER`- ustawia nazwę użytkownika (lub UID) używanego do uruchamiania obrazu i w momencie uruchamiania kontenera.

- `VOLUME` - deklaruje punkt montowania w kontenerze, używany do przechowywania danych. Docker utworzy nowe wolumeny dla każdego wskazanego w pliku.

- `ARG` - definiuje zmienną, którą można przekazać do Dockera podczas budowy obrazu za pomocą `docker build --build-arg <varname>=<value>`.

## Podstawowe komendy 

### Budowa obrazu 
```
docker build <OPCJE> <ścieżka_zawierająca_dockerfile_badz_url> 
```
<div style="text-align: justify"> 
służy do tworzenia obrazów Docker na podstawie instrukcji zawartych w pliku Dockerfile. Umożliwia automatyzację procesu tworzenia obrazu, który może być następnie używany do uruchamiania kontenerów.  

Przykładowe opcje jakie można wykorzystać w komendzie (więcej [tutaj](https://docs.docker.com/reference/cli/docker/image/build/)):
-    `-t, --tag` pozwala na nadanie tagu obrazowi, np. nazwa_użytkownika/nazwa_obrazu:wersja.
-    `--build-arg` umożliwia przekazanie argumentów do Dockerfile w czasie budowy.
-    `--no-cache` zmusza do niekorzystania z cache podczas budowy, co zapewnia, że wszystkie kroki są wykonywane od nowa.
-    `--rm` automatycznie usuwa tymczasowe kontenery utworzone podczas budowy obrazu.

</div>


#### Przykładowe użycie 




```
docker build --tag fiszki_frontend . 
``` 
Buduje obraz z tagiem "fiszki_frontend" w bieżącym katalogu.
(Pamiętać o kropce na końcu jak budujecie w bieżącym katalogu!!!) 
```
docker build --no-cache --tag fiszki_frontend .
``` 
Robi to samo co poprzednia komenda, ale wymusza na dockerze zbudowanie obrazu od nowa, nie aktualizując tylko zmian które są już w rejestrze.

### Startowanie obrazu
```
docker run <OPCJE> <nazwa_obrazu> <komendy> <argumenty>
```
Komenda ta zezwala na uruchomienie utworzonego już obrazu izolowanej aplikacji wraz z jej zależnościami w kontrolowanym środowisku. 


Przykładowe opcje

-    `-d, --detach` uruchamia kontener w tle.
-    `--name` pozwala na nadanie nazwy kontenerowi.
-    `-p, --publish` publikuje porty kontenera na hoście, np. `-p 80:80`.
-    `-v, --volume` montuje wolumin z hosta do kontenera, np. `-v /host/path:/container/path`.
-    `-e, --env` ustawia zmienną środowiskową w kontenerze, np. -e VAR=wartość.
-    `--rm` automatycznie usuwa kontener po jego zakończeniu.

#### Przykładowy start 

```
docker run -p 1200:80 --name fiszki_front fiszki_front
```

### Listowanie kontenerów 

```
docker ps
```

### Zatrzymanie kontenera
```
docker container stop <nazwa_kontenera> | <id_kontenera>
```

### Usunięcie obrazu 
```
docker remove <nazwa_obrazu> | <id_obrazu>
```
### Usunięcie kontenera
```
docker rm <OPCJE> <nazwa_obrazu> | <id_obrazu>
```

### Wejście do kontenera

```
docker exec <OPCJE> <ID_obrazu> | <nazwa_obrazu> <komenda> <argumenty> 
```
Opcje jakie prawdopodobnie wykorzystacie w czasie laboratorium:
- `-i`: tryb interaktywny, czyli możemy chodzić po kontenerze po wykonaniu polecenia
- `-t`: Przydziel pseudo terminal, w którym będziemy widzieć nasze poczynania


## Łączenie się między kontenerami 
Motywacja: Chcemy żeby kontener A mógł się łączyć z kontenerem B wewnątrz sieci dockera.

Potrzebne kroki: 
- ` docker network create <nazwa_sieci> ` - tworzymy sieć o jakiejś nazwie
- ` docker run --network=<nazwa_sieci> nazwa_obrazu` - odpalamy kontener w konkretnej sieci

Jak sobie monitorować sieć:
```
docker network inspect <nazwa_sieci>
```


## Montowanie pamięci do zachowywania danych pomiędzy sesjami działania kontenera 

1. Scieżka linią komend
```
docker volume create <nazwa_volumenu>

docker run -d --name moj_kontener -v moj_wolumen:/app my_image
```
2. Ścieżka z dockerfile'em
```
# wybranie obrazu z repozytorium dockera
FROM nginx:latest

VOLUME /usr/share/nginx/html

# Opcjonalnie: Otwórz port 80 dla ruchu HTTP
EXPOSE 80

# Przy starcie kontenera wykonaj tą komendę 
CMD ["nginx", "-g", "daemon off;"]
```



## Wymagane narzędzia, repozytoria, etc
- Docker oraz docker-compose.
- Repozytorium projektu. 
- Pobrany obraz bazy danych [MongoDB](https://hub.docker.com/_/mongo)  (wystarczy użyć komendę)
```
docker pull mongo
```

Na systemach operacyjnych typu Linux, może z automatu nie dodać waszego użytkownika do grupy docker. Jeżeli nie chcecie musieć dorzucać sudo do każdej komendy pożyteczne może być dodanie swojego konta do grupy docker. [Źródło](https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo). 

```
 sudo gpasswd -a $USER docker
```




## Zadania

### Co wysyłacie na Githuba

- plik dockerfile z bakcend-em 
- plik docker-compose (jeżeli ktoś zrobi zadanie na 5.0)
- Notatnik z listą komend które są wymagane do zaliczenia zadania. (prosiłbym żeby to było w roocie projektu jedynie)
- Chciałbym aby to wszystko było zrobione w ramach Pull Requesta do repozytorium. Pull Requesty jak zostaną ocenione zostaną zamknięte z komentarzem. 

### 3.0 - Hello world w Dockerfile 
Pobrać repozytorium a następnie w folderze `fiszki_backend` stworzyć plik Dockerfile. Następnie należy dodać:
- obraz bazowy z którego będzie budowany dockerfile (aplikacja była pisana oraz testowana w pythonie 3.10)
- zainstalować potrzebne zależności
- przekopiować pliki projektu do kontenera
- wykonać komendę startującą serwer.
- Sprawdzić czy się poprawnie zbuduje i odpali (patrz [Podstawowe komendy ](#podstawowe-komendy)) 

### 3.5 - Otworzyć aplikację na świat. 
Należy teraz sprawić aby aplikacja była dostępna z poziomu przeglądarki pod portem `8000`. (Patrz [Opcje dockerfile'a](#opcje-dockerfilea) i [Startowanie obrazu](#startowanie-obrazu)). Jeżeli wszystko pójdzie dobrze to będzie można się dostać do aplikacji pod linkiem `localhost:8000/`

### 4.0 - Połączyć aplikację back-endową z bazą danych

Nasza aplikacja powinna obsługiwać połączenie z bazą danych **mongoDB**. Wasze zadanie będzie polegało na tym:
- Pobrać obraz mongoDB z repozytorium dockera
- Utworzyć sieć między kontenerami.
- Odpalić ponownie kontener z back-endem, tym razem dodając jako parametr sieć do której ma zostać podpięty.
- To samo zrobić z obrazem bazy danych mongoDB 
- [Wskazówka](#łączenie-się-między-kontenerami) jak sprawdzić czy sieć którą stworzycie, ma podpięty jakikolwiek kontener.
- Ważne: aby po utworzeniu sieci i dodaniu kontenerów backend umiał rozmawiać z bazą danych należy dodać zmienną środowiskową o nazwie `DATABASE_URL` która będzie miała wartość `mongodb://<nazwa_kontenera_bazy_danych>:27017`
<!-- - Odpalić obraz z udostępnieniem portu 27017 -->

### 4.5 - Dodanie wolumenów do Dockerfile'a z bazą danych
- Należy stworzyć wolumen dla obrazu mongodb. 
- Należy następnie odpalić nasz obraz z bazą danych ponownie z dodatkową flagą `-v <nazwa_volume>:/<sciezka_do_danych_w_kontenerze>`
- Wskazówka: Informację gdzie mongoDB przechowuje swoje dane znajdziecie [tutaj](https://hub.docker.com/_/mongo)
- Weryfikacja czy wasz wolumen działa (na podstawie konteneru o nazwie backend):
```
docker exec -it backend bash
echo "Dane testowe" > /app/plik_testowy.txt
exit
docker rm -f backend
```

```
docker run -d --name backend_v2 -v moj_wolumen:/app moj_obraz
docker exec -it backend_v2 bash
cat /app/plik_testowy.txt
```

### 5.0 - Docker-compose (Jako taki dodatek)

#### Drobny wstęp
Docker compose jest narzędziem do definiowania i uruchamiania wielokontenerowych aplikacji Docker (Jak sami pewnie zobaczyliście, proces tworzenia wolumenów, sieci może być odrobinę upierdliwy).  Umożliwia użytkownikom konfigurację usług, sieci i wolumenów w jednym pliku YAML, co upraszcza proces konfiguracji i uruchamiania aplikacji z wieloma zależnościami. 
#### Przykład
```
version: '3.8'
services:
  frontend:
    # build: .
    image: frontend-image:latest
    ports:
      - "80:80"
    depends_on:
      - backend
    networks:
      - app-network

  backend:
    image: backend-image:latest
    ports:
      - "5000:5000"
    depends_on:
      - db
    networks:
      - app-network

  db:
    image: mongo
    volumes:
      - mongo_data:/data/db
    networks:
      - app-network

volumes:
  mongo_data:

networks:
  app-network:
```
Gdzie: 

- `version:` Wersja składni Docker Compose, 3.8 jest jedną z najnowszych dostępnych wersji.

- `services:` Definicja kontenerów, które mają być uruchomione jako część aplikacji.
    - `frontend`: Usługa frontendowa, używająca obrazu frontend-image:latest. Port 80 kontenera jest mapowany na port 80 hosta.
    - `backend`: Usługa backendowa, korzystająca z obrazu
        backend-image:latest. Port 5000 kontenera jest mapowany na port 5000 hosta. depends_on określa, że usługa backend powinna zostać uruchomiona po bazie danych.
    - `db`: Usługa bazy danych MongoDB, używająca oficjalnego obrazu mongo. Dane bazy danych są przechowywane na wolumenie mongo_data dla trwałości.

- `volumes:` Definicje wolumenów używane przez usługi, tutaj mongo_data jest wolumenem dla danych MongoDB.

- `networks:` Definicje sieci używane przez usługi, tutaj app-network jest siecią, która łączy wszystkie trzy usługi.

**Warte wspomnienia** - Docker-compose domyślnie sobie konfiguruje sieć w której są podpięte wszystkie kontenery

#### Komendy

```
docker compose up
```
Służy do zbudowania każdego z kontenerów (o ile już nie istnieją!!!) i ustawienia wszystkich zależności zdefiniowanych w docker compose. 
Potencjalnie przydatne flagi na czas labów:
- `-d` - odpala kontenery w tle.
- `--build` - wymuszenie zbudowania wszystkich kontenerów od nowa.

```
docker compose down
```
Wyłącza i usuwa kontenery utworzone przez docker compose'a. Zachowuje utworzone volumeny. 

#### Zadanie
Macie teraz stworzyć docker compose'a który:
- będzie tworzył kontenery dla backendu, frontendu i bazy danych (dockerfile do front-endu znajduje się w folderze fiszki_app)
- aplikacje będą umiały się ze sobą komunikować, z czego do backendu i do frontendu powinien być również dostęp z poziomu przeglądarki.
- I oczywiście należy stworzyć wolumen, tym razem możecie się ograniczyć tylko do bazy danych.


## Przydatne linki 

- Dokumentacja [docker-compose'a](https://docs.docker.com/compose/)
- Dokumentacja [dockera](https://docker-docs.uclv.cu/) 



