FROM python:3.10

WORKDIR /fiszki_backend

COPY . /fiszki_backend

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["python", "main.py"]

