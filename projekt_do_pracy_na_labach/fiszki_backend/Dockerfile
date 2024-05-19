FROM python:3.10

# RUN mkdir -p /usr/app
COPY requirements.txt /usr/app/requirements.txt
WORKDIR /usr/app
RUN pip install -r requirements.txt
COPY . /usr/app/
EXPOSE 8000
ENV DATABASE_URL=mongodb://fiszki_db:27017
CMD ["python3", "main.py"]