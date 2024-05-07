FROM python:3.10

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt 

COPY . . 

ENV "DATABASE_URL"="mongodb://mongo-example:27017"
EXPOSE 8000:8000

CMD ["python3", "main.py"]
