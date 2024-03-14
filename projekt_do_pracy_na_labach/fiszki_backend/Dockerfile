FROM python:3.10

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

#ENV DATABASE_URL="mongodb://siec:27017"

EXPOSE 8000

CMD ["python","main.py"]

#Komendy:

# 3.5:
# docker build --tag fiszki_backend . 
# docker run -p 8000:8000 --name fiszki_backend fiszki_backend

# 4.0:
# docker network create siec
# docker run -p 8000:8000 --network=siec --name fiszki_backend fiszki_backend 
# docker run -p 27017:27017 --network=siec --name mongo mongo
# docker network inspect siec