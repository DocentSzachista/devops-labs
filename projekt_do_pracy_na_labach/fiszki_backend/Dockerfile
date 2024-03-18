### 3.0
# Creating a new build stage from a base image python 3.10
FROM python:3.10

# Changing working directory to /fiszki_backend
WORKDIR /fiszki_backend

# Copying files and directories to /fiszki_backend/
COPY . /fiszki_backend/

# Executing build commands, downloading python libraries from "requirements.txt"
RUN pip install -r requirements.txt

# Describing which ports my application is listening on
EXPOSE 8000

# Creating env variable
# ENV DATABASE_URL=mongodb://fiszki_backend:27017

# Specifying default commands
CMD python main.py

## CLI \devops-labs\projekt_do_pracy_na_labach\fiszki_backend>
# Building image
# docker build -t fiszki_backend:1.0 .

# Starting container
# docker run -d --name fiszki_backend fiszki_backend:1.0

### 3.5
# Publishing a container's port(s) to the host
# docker run -d --name fiszki_backend --publish 8000:8000 fiszki_backend:1.0

### 4.0
# docker network create siec
# docker run -d -p 8000:8000 --name fiszki_backend --network=siec fiszki_backend:1.0
# docker run --name database -d --env DATABASE_URL=mongodb://fiszki_backend:27017 --network=siec mongo
# docker network inspect siec

### 4.5
# docker run -d --name fiszki_backend -p 8000:8000 -v volume:/app fiszki_backend:1.0
# docker run -d --name mongo -p 8001:8000 -v volume:/app mongo

# Volume verification
# docker exec -it fiszki_backend bash
# echo "x" > /app/obj.txt
# exit
# docker exec -it mongo bash
# cat /app/obj.txt -> output: x
# exit

### 5.0
# Creating \devops-labs\projekt_do_pracy_na_labach\fiszki_backend\compose.YAML 
# docker build -t fiszki_frontend:1.0 .
# docker compose up -d
# docker-compose down 