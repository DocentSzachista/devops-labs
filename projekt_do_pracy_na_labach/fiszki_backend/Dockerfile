FROM python:3.10
WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt
ENV "DATABASE_URL"="mongodb://mongo-example:27017"
CMD ["python", "main.py"]

EXPOSE 8000

#Na ocenę od 3 do 4.0
#docker build -t laby .
#docker network create moze
#docker run -d --network moze --name mongo_example -p 27017:27017 mongo:latest
#docker run -d --network moze --name laby_sieci -p 8000:8000 a839a7d7d199
#docker volume create laby_volume
#docker volume create mongo_volume
#Na ocenę 4.5 - dodane do wersji na 4.0 możliwość zawierania wolumenów
#docker run -d --network moze -v laby_volume:/app --name laby_example -p 8000:8000 laby:latest
#docker run -d --network moze -v mongo_volume:/app --name mongooo -p 27017:27017 mongo:latest
#docker exec -it laby_example bash  
#echo "Dane testowe" > /app/plik_testowy.txt
#cat /app/plik_testowy.txt
#exit

#Występował problem z uruchomieniem sieci mongoDB (nie otwiera się strona w przeglądarce)