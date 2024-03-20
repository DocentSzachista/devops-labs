FROM python:3.10
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt

CMD ["python", "main.py"]

EXPOSE 8000


# ZADANIE NA 3.0
# docker build --tag zad35 .

# ZADANIE NA 3.5
# Dodano "EXPOSE 8000"
# docker build --tag zad35 .
# docker run -p 8040:8000 --name zad35 zad35

# ZADANIE NA 4.0
# docker network create siec1
# docker run -d -p 8040:8000 --name zad35 zad35
# docker run -d --network=siec1 zad35
# docker run -d --network=siec1 mongo
# docker network inspect siec1     

# ZADANIE NA 4.5
# docker create volume vol1
# docker create volume vol2
# docker run -d --name cont_1 -v vol1:/app zad35 
# docker run -d --name cont_2 -v vol2:/app mongo
