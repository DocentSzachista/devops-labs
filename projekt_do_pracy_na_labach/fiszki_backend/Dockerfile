#Bartosz Habas

FROM python:3.10

WORKDIR /app

COPY . /app
RUN  pip install -r requirements.txt
EXPOSE 8000 

CMD ["python", "main.py"]



#docker build --tag fiszki_backend .

#docker run fiszki_backend 

#docker run -p 8000 fiszki_backend 

#docker network create siec1

#docker run --network=web_example fiszki_backend

#docker run --network=web_example mongo

#docker network inspect web_example
