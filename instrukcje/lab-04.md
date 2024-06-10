# Laboratorium 4 - InitContainers i inne magiczne sztuczki.

## Wstęp.
Macie już ogląd od strony deploy'owania aplikacji na kubernetesie, jak przechowywać dane a część z was nawet umie zrobić backup. Pora pokazać kilka dodatkowych narzędzi jakie Kubernetes ma do zaoferowania.

## InitContainers 

Są to kontenery które są tworzone przed odpaleniem faktycznego kontenera z waszą aplikacją. Ich główne wykorzystanie jest takie aby przygotowywać środowisko w którym aplikacja ma się znajdować, na przykład jak macie pod'a z bazą danych to zanim doda wam poda to najpierw możecie zgrać backup, a potem dopiero odpalacie bazkę.

### Przykładowy config:

```
 spec:
      containers:
      - name: mongodb-container
        image: mongo:latest
        ports:
        - containerPort: 27017
        volumeMounts:
        - name: mongo-data
          mountPath: /data/db
      initContainers:
      - name: check-backup
        image: busybox:latest
        command: ['sh', '-c', ' echo "Make Backup."']
        volumeMounts:
        - name: backup-volume
          mountPath: /data/backup
```

Jak widać config jest prawie taki sam.

## LiveNess i ReadinnesProbe

- Liveness Probe - jest to mechanizm, który sprawdza, czy aplikacja jest nadal aktywna i działa poprawnie. Liveness probe jest używana do wykrywania, czy aplikacja jest w stanie obsługiwać żądania, czy może została zawieszona lub uległa awarii. Przykładowo, może wysyłać żądania HTTP do serwera aplikacji i oczekiwać odpowiedzi z kodem stanu 200 OK. Jeśli odpowiedź nie jest zgodna z oczekiwaniami (na przykład otrzymujemy kod stanu 404 Not Found), to Kubernetes może zinterpretować to jako sygnał, że aplikacja nie działa poprawnie i podejmować odpowiednie działania, takie jak restart kontenera.

- Readiness Probe - jest to mechanizm, który sprawdza, czy aplikacja jest gotowa do obsługi żądań. Readiness probe jest używana do zapewnienia, że aplikacja jest w pełni skonfigurowana i gotowa do przyjęcia ruchu. Przykładowo, readiness probe może sprawdzać, czy aplikacja połączyła się z bazą danych i wczytała niezbędne dane do pamięci podręcznej. Jeśli readiness probe zakończy się niepowodzeniem, to aplikacja jest tymczasowo wyłączana z ruchu, aby uniknąć wysyłania do niej żądań, które mogą zakończyć się niepowodzeniem.

### Przykładowy config

```
apiVersion: v1
kind: Pod
metadata:
  name: moj-pod
spec:
  containers:
  - name: moj-kontener
    image: twoja-aplikacja-backendowa:latest
    ports:
    - containerPort: 8080
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 15
      periodSeconds: 20
    readinessProbe:
      httpGet:
        path: /readyz
        port: 8080
      initialDelaySeconds: 10
      periodSeconds: 15

```

- `livenessProbe` definiuje, jak Kubernetes sprawdza, czy aplikacja działa poprawnie. W tym przypadku, co `20` sekund Kubernetes wyśle żądanie `GET` na ścieżkę `/healthz` na porcie `8080` twojej aplikacji. Jeśli otrzyma odpowiedź inną niż kod `200`, uznaje, że aplikacja nie działa poprawnie. Pierwsze sprawdzenie zostanie wykonane po `15` sekundach od uruchomienia kontenera.

- `readinessProbe` definiuje, czy aplikacja jest gotowa do obsługi ruchu. Tutaj, co `15` sekund Kubernetes wysyła żądanie GET na ścieżkę `/readyz` na porcie `8080`. Jeśli otrzyma odpowiedź inną niż `kod 200`, uznaje, że aplikacja nie jest gotowa do obsługi ruchu. Pierwsze sprawdzenie zostanie wykonane po `10` sekundach od uruchomienia kontenera.

Wincej o tym znajdziecie [tutaj](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)

## Network policy

Po krótce jest to zasób który umożliwia kontrolę komunikacji sieciowej między różnymi zasobami klastra Kubernetes. Pozwala on definiować reguły, które określają, jakie połączenia sieciowe są dozwolone lub zabronione między różnymi zasobami, takimi jak pod, namespace, czy serwis.


### Przykładowy config

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-nginx
spec:
  podSelector:
    matchLabels:
      app: nginx
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          role: api
    ports:
    - protocol: TCP
      port: 80
  egress:
  - to:
    - podSelector:
        matchLabels:
          role: database
    ports:
    - protocol: TCP
      port: 3306
```
Krótkie wyjaśnienie:

- `spec.podSelector.matchLabels` - wybiera pody, do których Network Policy będzie stosowana na podstawie etykiet.
- `spec.policyTypes` - określa typy polityk, w tym przypadku Ingress i Egress, co oznacza, że ta polityka kontroluje zarówno przychodzące, jak i wychodzące połączenia.
- `spec.ingress` - definiuje reguły dla przychodzącego ruchu. W tym przykładzie pozwala na przychodzące połączenia TCP na porcie 80 z podów o etykiecie "role: api".
- `spec.egress` - definiuje reguły dla wychodzącego ruchu. W tym przykładzie pozwala na wychodzące połączenia TCP na porcie 3306 do podów o etykiecie "role: database".

Po wincej zapraszam do [dokumentacji](https://kubernetes.io/docs/concepts/services-networking/network-policies/)


## Zadania

### 3.0 /3.5 - LiveNess i ReadinessProbe czyli jak łatwo zdać te laby na 3.5 conajmniej

Waszym pierwszym zadanie będzie skonfigurować deployment backend'u tak, aby Kubernetes był w stanie sprawdzać, czy wasza aplikacja ciągle żyje oraz czy jest gotowa do użycia. Czyli tldr:

- Utworzyć `LiveNessProbe` który będzie odpytywał backend co 30 sekund czy "żyje" za pomocą endpoint'u `isAlive`

- Utworzyć `ReadinessProbe`, który odpytywać będzie backend co 20 sekund czy ma połączenie z bazą danych za pomocą endpoint\`u `isReady`





### 4.0 - Stwórzmy init container

W zależności czy utworzyliście StatefullSet czy Deployment dla bazy danych należy teraz stworzyć init container który:
- Sprawdzi czy są dane do przekopiowania. Jeżeli są ma je przekopiować do data `/data/db`.
- Jeżeli ich nie ma to ma po prostu się pojawić komunikat w logach.
- Jeżeli nie realizowałeś zadania z bazą danych i zadania z cronJobem to twoim zadaniem będzie jedynie wyrzucić komunikat czy pliki są czy ich nie ma. Plik z gotowym configiem statefullSeta jest na repozytorium

Podpowiedzi:
- Komenda aby pokazało komunikat `echo "tu wpisz swoj tekst"`.
- Komenda która skopiuje dane `cp -r <źródło> <miejsce_docelowe>`
- Przydatne będzie to wszystko okleić w warunek w polu `command`
- Komenda przykładowa:
  `["sh", "-c", "if [ -e /dsb/backup/example.txt ]; then echo 'Plik istnieje'; else echo 'Plik nie istnieje'; fi"]`

Aby sprawdzić czy potencjalny log się wydrukował polecam użyć tej komendy:

```
kubectl logs <nazwa-poda> -c <nazwa-init-containera>
```



### 5.0 A teraz ograniczmy ruch sieciowy.

#### Ważne
Domyślnie w minikubie nie działa network policy. Aby zaczęło działać należy zainstalować wtyczkę która na to zezwala, chociażby Calico.
Jak to zrobić.

1. Wrzucić komendę: `minikube start --network-plugin=cni --cni=calico`.
2. Poczekać aż się plugin zainstaluje. Można to podejrzeć za pomocą: `watch kubectl get pods -l k8s-app=calico-node -A`. Jak w kolumnie `READY` wam się wyświetli `1/1` to znaczy że wszystko już działa. Aby wyjść z poglądu wystarczy kliknąć kombinację klawiszy `Ctrl` + `C`. 
Jeżeli chcecie przetestować na jakimś gotowym przykładzie
https://docs.tigera.io/calico/latest/network-policy/get-started/kubernetes-policy/kubernetes-policy-basic


#### Faktyczna treść polecenia
To teraz zabawmy się w tworzenie network policy. Chciałbym dostać od was następujące rzeczy:

- Network policy które zezwala na ruch TYLKO pomiędzy podami należącymi do namespace'a waszej aplikacji. 
- Network policy ma zostać dodany do deployment'u / StatefullSeta z bazą danych
- Jakikolwiek ruch sieciowy spoza klastra ma być blokowany do podów bazy danych. 

Podpowiedzi: 
- należy zdefiniować ruch egress i ingress
- każdy z nich zawiera namespaceSelector, gdzie trzeba podać nazwę namespace'a do którego chcemy zezwolić na ruch.
- określić podSelector w spec który określi kubernetesowi które pody będą objęte zabezpieczeniem.


## Linki 

- https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/
- https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
- https://kubernetes.io/docs/concepts/services-networking/network-policies/


<!-- ### Mini projekcik do zbierania logów z kubernetesa. 

### 4.5 Dashboard co by zacząć od grafiki :p

#### Jak zawsze komentarz :P 
Generalnie jest to zadanie podobne do zadania z labów numer dwa ale zmieniamy apkę na grafanę. TLDR jest to taki dashboard którym możecie tworzyć różnego wizualizacje metryk pobieranych z logów, metryk aplikacji i oceniać zużycie. Jest to open source i ma kilka gotowców które można wykorzystywać :P.

Także wasz cel najpierw:
- Utworzyć deployment do grafany
- Udostępnić ruch aby dało się dostać do aplikacji z poziomu przeglądarki
- Ustawić sobie defaultowe hasło w konfiguracji (Tylko polecam nie ustawiać hasła z którego na codzień korzystacie, pamiętajcie, wrzucacie to potem na githuba!!!)
-  -->