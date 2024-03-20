FROM python:3.10

COPY . .

RUN pip3 install -r requirements.txt
# ENV DATABASE_URL="mongodb://mongo:27017"
EXPOSE 8000

CMD ["python3", "main.py"]
WORKDIR /app
WORKDIR /fiszki_backend

COPY . /fiszki_backend

RUN pip install --no-cache-dir -r requirements.txt

ENV "DATABASE_URL"="mongodb://mongoContainer:27017"

EXPOSE 8000

CMD ["python", "main.py"]

# 3.5
# docker build -t fiszki_backend .
# docker run -d --name fiszki_backend_cont --rm -p 8000:8000 fiszki_backend
#
# zeby zadzialalo stworzenie nowego kontenera z networkiem:
# sudo docker rm -f <id konterera stworzonego wczesniej>
#
# 4.0
# docker network create appnetwork
# docker run -d --name fiszki_backend_network --rm -p 8000:8000 --network=appnetwork fiszki_backend
# docker run -d --name mongo_network -e DATABASE_URL=mongodb://mongoContainer:27017 --network=appnetwork mongo
# docker network inspect appnetwork
#
# 4.5
# docker run -d --name fiszki_backend --rm -p 800:800 -v vol1:/fiszki_backend fiszki_backend
# docker run -d --name mongo --rm -p 80:800 -v vol1:/fiszki_backend mongo
#
# testing:
# docker exec -it fiszki_backend bash
# echo "testing" > /fiszki_backend/test.txt
# exit
# docker exec -it mongo bash
# cat /fiszki_backend/test.txt
# exit
#
#         _____                   /|
#         |   \      ____        / |
#   __    |    \    /\   |      /  ;
#  /\  \  |     \  /  \  |     /  ;
# /,'\  \ |      \/  : \ |    /   ;
# ~  ;   \|      /   :  \|   /   ;
#    |    \     /   :'  |   /    ;
#    |     \   /    :   |  /    ;
#    |      \ /    :'   | /     ;
#    |       /     :    |/     ;
#    |      /     :'    |      ;
#     \    /      :     |     ;
#      \  /      :'     |     ;
#       \       :'      |    ;
#        \______:_______|___;
#
