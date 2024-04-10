FROM python:3.10
ENV "DATABASE_URL"="mongodb://mongodb_ex:27017"
VOLUME /var/lib/docker/volumes/vol1/_data
WORKDIR /app
RUN pip install -r requirements.txt
COPY . /app
EXPOSE 8000
CMD ["python", "main.py"]

#Damian Janusz 259253
#na 3.5:
#docker build --tag fiszki_backend .
#docker run -p 8000:8000 --name fiszki_backend fiszki_backend

#na 4.0:
#docker pull mongo
#docker network create siec1
#docker run -d --network=siec1 --name mongodb_ex mongo
#docker build --tag fiszki_backend .
#docker rm $(docker ps -a -q -f status=exited)
#docker run -d --network=siec1 --name fiszki_backend fiszki_backend
#docker network inspect siec1

#połączenie zostało sprawdzone i działa

#na 4.5:
#docker volume create vol1
#docker volume inspect vol1
#docker build --tag fiszki_backend .
#docker run -d --name mongodb_ex -v vol1:/app mongo	#/data/db
#docker run -d --name fiszki_backend -v vol1:/app fiszki_backend
#docker exec -it fiszki_backend bash
#echo "Dane testowe" > /app/plik_testowy.txt
#exit
#docker rm -f fiszki_backend
#docker run -d --name fiszki_backendv2 -v vol1:/app fiszki_backend
#docker exec -it fiszki_backendv2 bash
#cat /app/plik_testowy.txt

#terminal pokazał zawartość pliku w postaci "Dane testowe"

#docker container stop fiszki_backend mongodb_ex
#docker rm $(docker ps -a -q -f status=exited)
#docker volume rm vol1

#nie działa docker compose
