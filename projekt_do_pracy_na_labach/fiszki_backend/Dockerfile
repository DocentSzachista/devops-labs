# zadanie na 3.0
FROM python:3.10  

# kopiowanie
RUN mkdir /app/
COPY . /app/


# katalog roboczy
WORKDIR /app

# instalacja
RUN pip install -r requirements.txt


# start maina (serwera)
CMD ["python", "main.py"]

# docker build --tag fiszki_backend .
# docker run fiszki_backend


# zadanie na 3.5 --> 
# docker run -p 8000:8000 fiszki_backend --> http://localhost:8000/

# zadanie 4.0 -->
# docker network create siec_laby
# docker run --network=siec_laby fiszki_backend
# docker run --network=siec_laby mongo
# docker network inspect siec_laby --> działa, wykrywa 2 kontenery

# zadanie 4.5 --> (starsza wersja zadania, nieuproszczona)
# docker volume create wolumen_zajecia
# docker run -v wolumen_zajecia:/app fiszki_frontend
# docker run -v wolumen_zajecia:/app mongo
# docker ps (żeby zobaczyć nazwy kontenerów)
# docker exec -it dreamy_williamson bash
# echo "Dane testowe" > /app/plik_testowy.txt
# exit
# docker exec -it clever_wing bash
# cat /app/plik_testowy.txt --> wynik komendy: Dane testowe
# exit
# czyli działa

