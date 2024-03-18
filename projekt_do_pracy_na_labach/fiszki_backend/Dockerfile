FROM python:3.10

WORKDIR /usr/src/app

COPY . .

RUN pip3 install -r requirements.txt
ENV DATABASE_URL="mongodb://mongo:27017"
EXPOSE 8000
CMD ["python", "main.py"]


#Bartosz Furmanek 259239

#Na 3
#docker build --tag backend .
#docker run backend

#Na 3.5 
#docker run -p 8001:8000 backend

#Na 4
#docker network create siec
#docker run --network=siec --name mongo -d mongodb/mongodb-community-server
#docker run -p 8001:8000 --network=siec --name backend backend
#docker network inspect siec -> Można znaleźć informacje ze w sieci są kontenery o nazwach backend i mongo

#Na 4.5
#docker volume create mongo_volume
#docker run --network=siec -v mongo_volume:/data/db --name mongo -d mongodb/mongodb-community-server 
#docker exec -it mongo bash 

#echo "Dane testowe" > /data/db/pliktestowy.txt
#exit
#docker rm mongo -f
#docker run --network=siec -v mongo_volume:/data/db --name mongov_2 -d mongodb/mongodb-community-server
#docker exec -it mongov_2 bash
#Wynik: Dane testowe
#exit
