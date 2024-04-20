FROM python:3.10

WORKDIR /app 

COPY . . 

RUN pip3 install -r requirements.txt

EXPOSE 8000

# ENV DATABASE_URL="mongodb://mongoDB:27017"

CMD ["python3", "main.py"]
