
FROM python:3.10


WORKDIR /app


COPY . /app


RUN pip install --no-cache-dir -r requirements.txt

# Wykonaj komendę startującą serwer
CMD ["python", "app.py"]
