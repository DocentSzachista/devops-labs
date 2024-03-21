FROM python:3.10

COPY . /fiszki_backend

WORKDIR /fiszki_backend

RUN pip install -r requirements.txt

EXPOSE 8000 

VOLUME /data/db

CMD ["python", "main.py"]



