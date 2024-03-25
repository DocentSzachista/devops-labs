FROM python:3.10

WORKDIR /fiszki_backend

COPY . /fiszki_backend

RUN pip install --no-cache-dir -r requirements.txt

ENV "DATABASE_URL"="mongodb://mongoContainer:27017"

EXPOSE 8000

CMD ["python", "main.py"]

# Start + zadanie na 3 i 3.5
# docker build -t contener1 fiszki_backend
# docker run -d --name contener1 --rm -p 8000:8000 contener1
# należy usunąć dockera o nazwie contener1 za pomocą 
# sudo docker rm -f contener1 
#
# Zadanie na 4
# docker network create appnetwork
# docker run -d --name fiszki_backend_network --rm -p 8000:8000 --network=appnetwork fiszki_backend
# docker run -d --name mongo_network -e DATABASE_URL=mongodb://mongoContainer:27017 --network=appnetwork mongo
# docker network inspect appnetwork- wyświetla potwierdzenie połączenia
#