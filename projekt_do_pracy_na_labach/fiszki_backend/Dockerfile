FROM python:3.10

WORKDIR /app

COPY . . 

RUN pip3 install -r requirements.txt

EXPOSE 8000

ENV DATABASE_URL=mongodb://kontener_mongodb:27017

CMD ["python", "main.py"] 
#1
#docker build --tag docbuild
#docker run dockbuild

#2
#docker run dockbuild -p 8000:8000

#3
#docker network create siec1
#docker run --network=siec1 -d --name=backend -p 8000:8000 docbuild
#docker run --network=siec1 -d --name=kontener_mongodb mongodb/mongodb-community-server
#docker network inspect siec1

#4
#docker volume create volumen_mongodb
#docker run -d --name=kontener_mongodb --network=siec1 -v volumen_mongodb:/data/db mongodb/mongodb-community-server
#docker exec -it kontener_mongodb bash
#echo "Dane testowe" > /data/db/plik_testowy.txt
#exit
#docker rm -f kontener_mongodb
#docker run -d --name=kontener_mongodb_v2 --network=siec1 -v volumen_mongodb:/data/db mongodb/mongodb-community-server
#docker exec -it kontener_mongodb_v2 bash
#cat /data/db/plik_testowy.txt
#mongodb@5b106218ecde:/$ cat /data/db/plik_testowy.txt
#Dane testowe