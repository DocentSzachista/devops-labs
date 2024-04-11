FROM python:3.10

WORKDIR /app

COPY . .

ENV "DATABASE_URL"="mongodb://mongodb:27017"

RUN pip install --no-cache-dir -r requirements.txt 

EXPOSE 8000

CMD ["python" , "main.py"]


"""
git clone https://github.com/TanskiSzymon/devops-labs.git
cd devops-labs
cd projekt_do_pracy_na_labach/
cd fiszki_backend/
nano Dockerfile
docker build -t fiszli_backend .
docker run fiszli_backend
docker stop
docker ps
docker run -p 8000:8000 --name fiszkiP fiszli_backend
docker network create app-network
docker run -p 8000:8000 --network=app-network --name fiszkiback fiszli_backend
docker run -d --name mongodb --network app-network mongo
docker run -d --name fiszki_backend2 --network app-network -e DATABASE_URL=mongodb://mongodb:27017 fiszki_backend
docker network inspect app-network
docker volume create
docker volume create fiszki
docker volume create mongo
docker ps
docker stop f33bc5d9aecb
docker remove f33bc5d9aecb
docker stop 1071db122ef5
docker remove 1071db122ef5
docker ps
docker run -d --name mongodb --network app-network -v mongo:/data/db mongo
docker run -d --name fiszki_backend2 --network app-network  -v fiszki:/app fiszki_backend
docker exec -it fiszki_backend_kontener bash -c "echo 'Dane testowe' > /app/plik_testowy.txt"
docker exec -it fiszki_backend2 bash -c "echo 'Dane testowe' > /app/plik_testowy.txt"
docker rm -f fiszki_backend2
docker run -d --name fiszki_backend2 --network app-network  -v fiszki:/app fiszki_backend
docker exec -it fiszki_backend2 bash
cat /app/plik_testowy.txt
"""
