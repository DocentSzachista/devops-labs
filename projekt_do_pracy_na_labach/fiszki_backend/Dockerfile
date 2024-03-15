FROM python:3.10

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

ENV "DATABASE_URL"="mongodb://mongoContainer:27017"

EXPOSE 8000

CMD ["python", "main.py"]

# sudo docker run -p 8000:8000 --rm --name fiszki_backend fiszki_backend
# docker network create appnetwork
# docker volume create vol1
# docker volume create vol2
# docker run -d --name mongoContainer --network appnetwork -v vol1 mongo #cos dodac? moze -e
# docker run -p 8000:8000 -d --name fiszki_backend --network appnetwork -v vol2 fiszki_backend
