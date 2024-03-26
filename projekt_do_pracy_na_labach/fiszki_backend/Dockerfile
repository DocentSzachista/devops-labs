FROM python:3.10

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt
ENV DATABASE_URL="mongodb://mongo:27017"
EXPOSE 8000

CMD ["python", "main.py"]

#3.5
#docker build -t --name lab1:v1 .
#docker run -d --name kontener1 -p 8000:8000 lab1:v1 

#4.0
#docker network create siec 
#docker network create siec_mongo
#docker run -p 8000:8000 --network=siec_mongo --name kontenermongo labmongo:v1
#docker run -p 27017:27017 --network=siec_mongo --name mongo mongo:latest
#mongo niestety nie działa nawet po podmienieniu DATABASE_URL na nazwe kontenera

#4.5
#docker volume create wolumen
#docker volume ls
#docker run -d -v wolumen:/app --name kontenerwolumen -p 8000:8000 labmongo:v1
#exec -it kontenerwolumen bash
#echo "Dane testowe" > /app/plik_testowy.txt
#manualnie usunałem kontener "kontenerwolumen" w docker desktop
#docker run -d -v wolumen:/app --name kontenerwolumen2 -p 8000:8000 labmongo:v1
#docker exec -it kontenerwolumen2 bash
#cat /app/plik_testowy.txt
# na output wyszło root@3ce59a221f92:/app# cat /app/plik_testowy.txt Dane testowe
# to dowod ze działa wolumen