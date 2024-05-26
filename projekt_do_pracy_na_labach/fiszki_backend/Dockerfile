FROM python:3.10

COPY . .

RUN pip3 install -r requirements.txt
# ENV DATABASE_URL="mongodb://mongo:27017"
EXPOSE 8000 

CMD ["python3", "main.py"]