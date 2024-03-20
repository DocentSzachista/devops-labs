FROM python:3.10

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

ENV DATABASE_URL="mongodb://mongo:27017"

EXPOSE 8000

CMD ["python","main.py"]

#Komendy:

# 3.5:
# docker build --tag fiszki_backend . 
# docker run -p 8000:8000 --name fiszki_backend fiszki_backend

# 4.0:
# docker network create siec
# docker build --tag fiszki_backend .
# docker run -p 8000:8000 --network=siec --name fiszki_backend fiszki_backend 
# docker run -p 27017:27017 --network=siec --name mongo mongo
# docker network inspect siec
# ta część dalej nie działa nawet po dodaniu linijki 7 (tak jak na labach)

# 4.5:
# docker volume create wolumin
# docker run -p 8000:8000 -v wolumin:/app --name fiszki_backend fiszki_backend
# docker run -p 27017:27017 -v wolumin:/app --name mongo mongo
# docker exec -it fiszki_backend bash
# echo "Dane testowe" > /app/plik_testowy.txt
# exit
# docker rm -f fiszki_backend
# docker run -d --name backend_v2 -v wolumin:/app fiszki_backend
# docker exec -it backend_v2 bash
# cat /app/plik_testowy.txt
# tutaj się wyświetla zawartość plik_testowy.txt zapisana wcześniej czyli "Dane testowe" więc wolumen działa 