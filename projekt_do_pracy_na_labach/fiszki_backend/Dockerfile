FROM python:3.10


RUN mkdir /app/ 
COPY . /app/

WORKDIR /app 

RUN pip install -r requirements.txt 

CMD ["python", "main.py"]

#Karol Jantas 
#na 3.0
#docker build --tag fiszki_frontend .
#docker run fiszki_frontend 

#na 3.5
#docker run -p 8000:8000 fiszki_frontend 

#na 4.0
#docker network create siec1
#docker run --network=siec1 fiszki_frontend
#docker run --network=siec1 mongo
#docker network inspect siec1

#na 4.5 starsza wersja zadania 
#docker volume create wolum1
#docker run -v wolum1:/app fiszki_frontend
#docker run -v wolum1:/app mongo 
#docker exec -it <nazwa_kontenera> (fiszki_frontend) bash
#cat /app/plik_testowy.txt
#echo "test" >app/plik_testowy.txt
#exit
