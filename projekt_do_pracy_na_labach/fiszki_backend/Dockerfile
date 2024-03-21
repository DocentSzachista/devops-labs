#3.0
# Sepcifying the base image
FROM python:3.10

LABEL container_label = " Docker labs Monday "

# Setting the working directory
WORKDIR /fiszki_backend

# Coppying files form workspace to container
# Possible to use `ADD . .`, if needed to download URL 
COPY . /fiszki_backend/

# Downloading necessary libraries from "requirements.txt"
RUN pip install -r requirements.txt

# Proposing the optimal port
EXPOSE 8000

# Command used when starting the container
CMD ["python", "main.py"]

# Command line commands
# Building the image
# -t: own tag
# docker build -t <image_name> .
# docker build -t fiszki_backend:v1 .

# Starting the container 
# -d: run container in the background and print id (keeps terminal clean)
# --name: assign a name to the container
# docker run -d --name <container_name> <image_name>
# docker run -d --name fiszki_backend_container-v1 fiszki_backend:v1

#3.5
# -p: publish container to the host
# docker run -d --name fiszki_backend_container-v1 -p 8000:8000 fiszki_backend:v1

#4.0
# docker network create siec_1
# docker run -d --name fiszki_back_siec -p 8000:8000 --network=siec_1 fiszki_backend:v1
# docker run -d --name mongo_siec -e DATABASE_URL=mongodb://fiszki_backend:27017 --network=siec_1 mongo
# docker network inspect siec_1

#4.5
# docker volume create mongo_volume
# docker run -d --name mongo_container -p 81:80 -v mongo_volume:/data/db mongo
# docker volume ls

# Checking if volume is connected
# docker exec -it mongo_container bash
# echo "test" > /data/db/test.txt
# exit
# docker rm -f mongo_container
# docker run -d --name verification -v mongo_volume:/data/db mongo
# docker exec -it verification bash
# cat /data/db/test.txt -> output: test

#5.0
# cd /<change directory>
# docker build -t fiszki_app:v1 .
# docker-compose up -d --force-recreate
# docker-compose down 

# w tym przypadku próbowałem wiele rozwiązań jednak okazało się że to 
# jest jedyne działające, gdyż nie bylem w stanie otworzyć jednego pliku
# `.yaml`.

##############################################################
# rozwiązanie problemu z lini 64/66 pod linkiem https://stackoverflow.com/questions/38586028/docker-compose-up-d-name-no-such-service-name