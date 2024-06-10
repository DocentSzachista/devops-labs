FROM python:3.10
WORKDIR /app
COPY . .
RUN pip3 install -r requirements.txt
eXPOSE 8000
CMD ["python", "main.py"]


COPY . .

RUN pip3 install -r requirements.txt
# ENV DATABASE_URL="mongodb://mongo:27017"
EXPOSE 8000 

CMD ["python3", "main.py"]