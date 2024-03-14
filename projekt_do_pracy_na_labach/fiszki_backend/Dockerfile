FROM python:3.10

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

ENV DATABASE_URL="mongodb://siec:27017"

EXPOSE 8000

CMD ["python","main.py"]