#3.0
FROM python:3.10

WORKDIR /fiszki_backend

COPY . /fiszki_backend/

RUN pip3 install -r requirements.txt

EXPOSE 8000

CMD ["python3", "main.py"]

#docker build -t fiszki_backend:v1 .


#3.5
#docker run -d -p 8000:8000 --name fiszki_backed_container-v2 fiszki_backend:v1

#4.0
#docker network create siec
#docker network ls
#docker run -d -p 8001:8000 --name fiszki --network=siec fiszki_backend:v1
#docker run --name database -d --env DATABASE_URL=mongodb://fiszki_backend:v1:27017 --network=siec mongo
#docker network inspect siec


#4.5
#docker run -d --name fiszk34  -p 8000:8000 -v volume:/app fiszki_backend:v1
#docker run -d --name mongo -p 8001:8000 -v volume:/app mongo
#docker exec -it mongo bash
#docker exec -it fiszk34 bash



