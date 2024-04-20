FROM python:3.10

# sciezka startowa
WORKDIR /app 

COPY . . 

RUN pip3 install -r requirements.txt

# tylko informacyjna
EXPOSE 8000

# ENV DATABASE_URL="mongodb://mongoDB:27017"

#jak nie działa to bez nawiasów i przecinka
CMD ["python3", "main.py"]
