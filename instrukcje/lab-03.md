# Laboratorium 3 - O storage'u słów kilka(dziesiąt)

## Wstęp

<p style="text-align:justify">

No to już udało się nam zdeployować aplikację,  nawet otworzyliśmy ruch na świat, oraz podpieliśmy aplikację do bazy danych. Także teraz przydałoby się te dane jakoś przetrzymywać.

</p>

## PersistentVolume i StatefullSet

<p style="text-align:justify">
Jak w przypadku dockera mieliśmy wolumeny to w przypadku Kubernetesa mamy `PersistentVolume`. Jego rola w zasadzie jest taka sama jak <b>wolumenów</b> w Dockerze, czyli tworzyć przestrzeń w której dane będą trzymane i w razie przypadku usunięcia poda przywracanie jej z powrotem wraz z odtworzeniem poda. 
</p>

<p style="text-align:justify">
Jezeli chodzi o StatefullSet jest to konkretny typ kontrolerów w Kubernetesie (tak jak <b>deployment</b> w poprzednim laboratorium), który zapewnia unikalność i trwałość stworzonych podów w klastrze.

No dobra ale jak ta unikalność działa? 

<p style="text-align:justify">
Otóż jak tworzycie Pody samemu albo za pośrednictwem innych kontrolerów to każdy z podów ma <b>losowo</b> wygenerowane unikalne ID. W przypadku StatefullSeta każdy z podów ma unikalne ID które jest łatwo przewidzieć pod kątem wartości gdyż jest w zakresie od 0 do N-1, gdzie N to liczba replik StatefullSet'a. Każdy ze stworzonych StatefullSet'ów ma od razu skonfigurowany <b>PersistentVolume</b>, do którego będą przechowywane dane w zależności od stworzonego przez nas template'a w configu.
</p>


Przykładowy rozstawienie podów dla stworzonego StatefullSeta z dwoma replikami (użyto komendy `kubectl get pods -l app=nginx`)
```
NAME      READY     STATUS    RESTARTS   AGE
web-0     1/1       Running   0          1m
web-1     1/1       Running   0          1m
```



## ConfigMap

<p style="text-align:justify">
Jak nazwa wskazuje jest to struktura do trzymania konfiguracji. Mogą to być słowniki, mogą to być pliki. Ich celem jest po prostu to aby móc łatwo wrzucać konfiguracje aplikacji bez męczenia się pisać klauzul env bez końca (a potem co gorsza je jeszcze modyfikować).
</p>



## Przykłady

### StatefullSet
```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  serviceName: "nginx"
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: registry.k8s.io/nginx-slim:0.8
        ports:
        - containerPort: 80
          name: web
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 1Gi
```
To co zmieniło się w porównaniu do poprzednich labów to dodanie `volumeClaimTemplates` oraz zmiana typów kontrolera z `Deployment` na `StatefullSet`. Także `volumeClaimTemplates` są to szablony żądań woluminów używane do dynamicznego tworzenia woluminów dla każdej repliki w StatefullSecie. Kubernetes utworzy dla każdej z repliki żądany wolumen oraz jeżeli w czasie pracy któryś pod przestanie działać to dzięki unikalnym ID po resecie dane zostaną odpowiednio przydzielone do replik. A teraz przejdźmy do opcji jakie ten template posiada:

- `metadata:` Metadane dla szablonów woluminów.
    - `name:` Nazwa szablonu woluminu.
- `spec:` Specyfikacja dla woluminu, który zostanie utworzony.
- `accessModes:` Tryb dostępu do woluminu, tutaj `ReadWriteOnce`. Konkretny opis trybów dostępu znajdziecie [tutaj](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes)
- `resources`: Zasoby wymagane przez wolumin.
    - `requests`: Żądane zasoby, tutaj `storage`: `1Gi`.


### PersistentVolume
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: example-backend-volume
spec:
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: standard
  hostPath:
    path: /path/to/host/folder 
```
- `capacity`: Określa pojemność woluminu, w tym przypadku `1 gigabajt`.

- `volumeMode`: Tryb woluminu, w tym przypadku `Filesystem`.
- `accessModes`: Określa dostępne tryby dostępu, w tym przypadku `ReadWriteOnce`, co oznacza możliwość jednoczesnego odczytu i zapisu tylko dla jednego woluminu.
- `persistentVolumeReclaimPolicy`: Określa politykę dotyczącą zatrzymywania woluminu po usunięciu zasobu, w tym przypadku Retain, co oznacza, że wolumin zostanie zachowany i może być ręcznie przywrócony po usunięciu.
- `storageClassName`: Nazwa klasy magazynowania, która definiuje sposób, w jaki wolumin jest dynamicznie przypisywany do PV.
- `hostPath`: Ścieżka na hoście, do której jest montowany wolumin.





### PersistentVolumeClaim
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: example-backend-volume-claim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: standard
```

- `spec`: Zawiera specyfikację dla żądania wolumenu trwałego.

- `accessModes`: Określa dostępne tryby dostępu do wolumenu. Tutaj ustawiony jest tylko jeden tryb ReadWriteOnce, co oznacza, że wolumen może być montowany w trybie tylko do odczytu/zapisu przez jedno urządzenie w danym czasie.

- `resources`: Określa żądane zasoby dla wolumenu.
- `requests`: Określa minimalne wymagane zasoby. Tutaj ustawiona jest żądana pojemność przechowywania na poziomie 1 gigabajta (1Gi).

- `storageClassName`: Określa klasę magazynu, która ma być używana do tworzenia wolumenu. Tutaj używana jest klasa standard, która jest jedną z domyślnych klas dostępnych w klastrze Kubernetes.


### ConfigMap
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: example-configmap
data:
  # Definicja kluczy i wartości bezpośrednio
  key1: value1
  key2: value2
  key3: value3
```

## Zadania

### 3.0 Rozgrzewka i przykładowe zastosowanie Wolumenów
Należy utworzyć wolumen dla backend'u aby była możliwosć przetrzymywania logów z działania aplikacji.
Co należy zrobić:
- Utworzyć `PersistentVolume` tak jak w [przykładzie](https://minikube.sigs.k8s.io/docs/handbook/persistent_volumes/)
    - Podmienić ilość zapisywanej pamięci na mniejsza niż `1Gi`. 
    - Ustawić ścieżkę zapisu danych na hoscie na: `/data/pv_backend/`
    - Ustawić nazwę dla PersistentVolume `pv_backend`
    - Ustawić namespace w którym ma zostać stworzone volume 
- Utworzyć `PersistentVolumeClaim` tak jak w [przykładzie](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/#create-a-persistentvolumeclaim) 

- Dodać Wolumin do Deploymentu 

### 3.5 No to pora zabezpieczyć Wolumen
Może się zdarzyć tak, że ktoś nieopatrznie będzie chciał skorzystać z waszego PersistentVolume, albo ktoś źle skonfiguruje deployment i logi będzie zapisywał w waszym przydzielonym storage'u. Zdarza się, jako devops zazwyczaj będzie współpracować z ludźmi, i będziecie poprawiać ich błędy albo oni wasze. (Jak sądzicie skąd **Doktroll** mnie wytrzasnął? XD). 

Co należy zrobić?
- W PersistentVolume dodać po prostu jedną opcję a konkretnie `claimRef` z określeniem następujących rzeczy:
    - nazwy `PersistentVolumeClaim`
    - namespace'a gdzie się ten `PersistentVolumeClaim` znajduje


### 4.0 - Poprawienie grzechów z lab 3 
Należy utworzyć Statefull Set zamiast Deploymentu z bazą danych 
Czyli inaczej co trzeba zrobić: 
- Wejść na stronę dokumentacji [StatefullSet](https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/), bądź w [instrukcję](#statefullset) i przekopiować definicję StatefullSet'u.
- Zmienić nazwy w metadanych na nazwy znaczące, na przykład `MongoStatefullSet` (to jest tylko przykład, błagam, nie nazywajcie wszyscy tak samo xD). 
- Podmienić obraz z nginx'a na obraz mongo oraz podmienić:
    - ścieżkę wolumenu na taką, gdzie zapisywane są dane
    - udostępniany port
    - Podmienić `volumeClaimTemplate` a konkretnie można mu zmienić nazwę Claim'a oraz wymagania pamięci na `500Mi`(Może być mniej)

### 4.5 Stworzenie config mapy, która będzie zawierać ustawienia back-endu

Trochę zadanie na siłę ale niech będzie. Generalnie co musicie zrobić:

- Stworzyć configmapę która będzie zawierała następujące pola:
    - tryb logging'u, pole powinno sie nazywać "logging", wartości jakie przyjmuje to `INFO` i `DEBUG`
    - Link łączący się do bazy danych (W poprzednich labach dodawaliście go jako env). Nazwa zmiennej powinna pozostac taka sama.
- Dodać zmienne z configmapy do [deploymentu](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#define-a-container-environment-variable-with-data-from-a-single-configmap)

#### Komentarz
Generalnie config mapę używa się do trzymania różnego rodzaju konfiguracji, które są potrzebne podczas startu aplikacji czy podczas jej działania. 

### 5.0 Ludzie dzielą się na 2 grupy... tych co robią backup i tych co będą robić backupy

#### Zbędny komentarz prowadzącego (a może nie)
Tak to żeby nie było za łatwo i jednak był przesiew w ocenach. A tak bardziej serio, w pracy moze (raczej na pewno) wam się przydać tworzenie backupów bo nigdy nie wiadomo co się w życiu [stanie](https://eskom.eu/blog/co-to-jest-zasada-backupu-3-2-1). To zadanie będzie odrobinę prowizorką realnego zastosowania ale w praktyce będzie wymagało od was jedynie podmianę jednego pliku / komendy, reszta powinna pozostać tak jak teraz zrobicie.

#### CronJoby i Joby

Są to po krótce zadania które zlecacie Kubernetesowi wykonać, na przykład backupy. CronJoby zezwalają na zlecanie zadań co określony okres czasu na przykład, raz w tygodniu albo co godzinę. Po bardziej szczegółowy opis odsyłam was [tutaj](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/).


#### To co zrobić macie.
Na sam start 
- Tworzycie CronJoba na podstawie tej [definicji](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#example)
    - podmieniacie nazwę na jakąś znaczącą
    - Ustawiacie cron'a tak aby wykonywał się co 24h o godzinie 02:00 czasu CET. Jak ustawiać cron'a polecam tą [stronę](https://crontab.guru/). 
        - Komentarz: Na potrzeby sprawdzenia czy skrypt działa polecam stworzyć sobie cronJoba wykonującego się co na przykład 2 minuty. A potem podmienić na właściwy.
    - W pole command polecam użyć coś takiego:
    ```
    command: ["sh", "-c", "mongodump --host mongodb-service-0.mongodb-service --db fiszki --out /backup/$(date +%Y-%m-%d_%H-%M-%S)"]  
    ```
    - Podmiencie obraz na mongo.

Patrzycie następnie na status CronJoba i patrzycie czy się wykonał na dashbordzie minikube'a. Dla osób działajacych na instancjach kubernetesa bez minikube'a po utworzeniu CronJoba polecam użyć tej komendy by sobie zweryfikować czy wam działa:

```
kubectl get jobs --watch
```
Ta komenda zaczyna tworzyć wszystkie joby utworzone na kubernetesie na przestrzeni nazw default. Przykładowe wyjście:

```
NAME               COMPLETIONS   DURATION   AGE
hello-4111706356   0/1                      0s
hello-4111706356   0/1           0s         0s
hello-4111706356   1/1           5s         5s
```
