FROM python:3.10

WORKDIR /app

COPY .  . 

RUN pip3 install -r requirements.txt
#ENV DATABASE_URL="mongodb://<nazwa_kontenera_bazy_danych>:27017"
EXPOSE 8000

CMD ["python","main.py"]