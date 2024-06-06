FROM python:3.10

<<<<<<< HEAD
WORKDIR /fiszki_backend

COPY . /fiszki_backend

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["python", "main.py"]

=======
COPY . .

RUN pip3 install -r requirements.txt
# ENV DATABASE_URL="mongodb://mongo:27017"
EXPOSE 8000 

CMD ["python3", "main.py"]
>>>>>>> upstream/master
