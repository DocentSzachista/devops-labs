# Laboratorium 5 - Helm charts czyli jak automatyzować toola do automatyzacji.

## Wstęp 
Jest duża szansa na to że jak ktoś z was pójdzie pracować jako DevOps, to prędzej czy później wiedza o Helm'ie się przyda.

## Czym jest Helm

Tak po krótce jest to menadżer pakietów który zezwala na automatyzacje wdrażania aplikacji oraz szybką modyfikację ich konfiguracji bez konieczności szukania opcji po pojedynczych plikach.

### Struktura plików w helmie
```
chart.yaml
templates/
    -> deployment.yaml
    -> service.yaml
    ...
values.yaml
notes.txt
```

- `chart.yaml` Trzyma informacje o wersjonowaniu, nazwie oraz opisie projektu. Może też trzymać informacje o wymaganych dependencjach w projekcie.
- `notes.txt` jest to plik w którym można zamieścić potrzebne dla użytkownika informacje po instalacji projektu.
- `templates` Folder w którym są trzymane templatki zasobów które zostaną podczas instalacji utworzone. Korzystają one z pliku `values.yaml` z którego pobierają wartości, na przykład liczbę replik czy porty na których aplikacja ma zostac udostepniona.

## Podstawowe komendy
- ```helm create <nazwa-projekt>``` - Jest to komenda która w ścieżce której jesteście wszystkie wymagane pliki do helm chart'a.

- ```helm install <nazwa-instalacji> <scieżka-do-projektu>``` - instaluje projekt do klastra kubernetesowego. 
    - Pierwszy argument to jest po prostu nazwa do jakiej będziemy chcieli się potem odwoływać w helmie
    - Drugi argument to jest ścieżka do projektu. Musi się projekt znajdować w jednym z dodanych repozytoriów.

    - Przykładowe wywołanie:
    
    ```
    helm install wordpress stable/wordpress
    ```     
- ```helm upgrade <nazwa-instalacji> <nazwa-chart'a>```
Jest to komenda mająca wrzucić  aktualizację projektu który zainstalowaliście, aby był zgodny z najnowszą wersją charta. Można też aktualizować wartości `values.yaml` po dodaniu flagi `--set`. Przykład:

```
helm upgrade my-wordpress stable/wordpress --set wordpress.imageSize=512Mi
```

- `helm repo add <nazwa> <link_do_repozytorium> ` - dodajemy link do publicznego repozytorium gdzie są przechowywane pliki ustawiające projekt. Przykład:
```
helm repo add stable https://charts.helm.sh/stable
```

- ``` helm repo update ``` - jest to komenda aktualizująca wszystkie zależności w repozytoriach.

- ``` helm delete <nazwa-instalacji>``` usuwa zainstalowany projekt przez nas z klastra kubernetesowego. Przykład:
```
helm delete my-wordpress
```
## Jak pisać własne helm charty i podkładać wartości.
Pisanie helm chartów wygląda tak, że bierzecie konfigi które pisaliście do kubernetesa (chociażby deployment, Serwisy itd) i dodajecie w ich polach odwołania do pliku values.yaml, które wygląda na przykład tak:

`{{.Values.backendServer.imagePullPolicy}}`

Kluczowe jest aby dodać dwie klamry otwierające i dwie zamykające. Następne `.Values` znaczy tyle że odwołujecie się do pliku `values.yaml` a ścieżki podane po kropkach odwzorowują strukturę tego pliku. W powyższym przykładzie odwołujemy się do wartości pola `imagePullPolicy` które należy do zbioru wartości `backendServer`.

I cała zabawa w najprostszym możliwym przypadku sprowadza się do czegoś takiego:

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  namespace: apka
  labels: 
    app: inny
spec:
  containers:
  - name: nginx
    image: fiszki_backend:latest
    imagePullPolicy: {{.Values.backendServer.imagePullPolicy}}
    ports:
    - containerPort: {{.Values.backendServer.containerPort}}
```
i taki plik values.yaml:
```
backendServer:
  imagePullPolicy: IfNotPresent
  containerPort: 80
```

Istnieje wiele więcej featerów w helmie, chociażby uwzględnianie zasobów warunkowo, lecz na potrzeby labów nie będą potrzebne. Dla zainteresowanych odsyłam do stronki dokumentacji [Helm'a.](https://helm.sh/docs/chart_template_guide/getting_started/) 

## Zadania

### 3.0 i 3.5 Korzystanie z gotowców be like

Z racji, że najczęściej korzysta się już z gotowych paczek to na pierwszy ogień pójdzie ogarnięcie Grafany i Prometheusa. TLDR Grafana jest to narzędzie do wizualizacji różnego rodzaju danych zaczynając od liczby zapisów w bazie danych a kończac na wyciąganiu informacji o zużyciu procesora. Prometheus natomiast jest to stricte narzędzie do monitorowania środowisk programistycznych. Udostępnia API z którego latwo można pobierać metryki.

Także po przykrótkim wprowadzeniu do narzędzi oto co macie zrobić:
- Na 3.0
    - Pobrać i zainstalować helm chart prometheus'a  
    - Pobrać i zainstalować helm chart grafany 
    - Udostępnić grafanę do logowania się przez przeglądarkę (Możecie napisać sobie serwis do tego, możecie zrobić port forwarding przez linię komend)
- Na 3.5
    - Dodać pomiary dla metryk z prometheusa np zużycie procesora, pamięci, ramu. 
    - Polecam skorzystać z gotowców będących w internecie. Nikt sam tego nie robi :p
    - Możliwe że część wykresów nie będzie wam działać ale jest to już poza zakresem tego kursu. 


### Wasz własny helm chart

W repozytorium na ścieżce `projekt_helm` został utworzony gotowy projekt helm chart'a. Waszym zadaniem będzie go po prostu uzupełnić.


#### 4.0 Taka ocena za free 
Można skonfigurować helm charta tak aby nam wyświetlał jakieś dodatkowe informacje po instalacji aplikacji. Dlatego proszę sobie dodać taki plik o nazwie `notes.txt` i napisać cokolwiek. Może być żarcik, może być suche hello world. Twórczość pozostawiam wam. Jak ktoś chce może się pobawić go template'ami. Po więcej odsyłam [tutaj](
https://helm.sh/docs/chart_template_guide/notes_files/):



#### 4.5 i 5.0 Pora na wasz własny deployment 

W zależności od tego co pracodawca będzie chciał to będziecie musieli pewnie wydać taki helm chart by zautomatyzować potok CI/CD i łatwo podmieniać różne wartości.

Ale do rzeczy co jest tutaj dla was do zrobienia: 

1. W pliku values.yaml dodać następujące wartości: 
    - liczba replik jaka ma być tworzona do deploymentu
    - tag jaki ma być przyporządkowywany do obrazu
    - Port na jakim ma się wystawić aplikacja z backend'em.
    - politykę pobierania obrazów.
2. Dodanie do templates plików konfiguracyjnych deploymentu, serwisu dla backend'u.
3. Następnie należy dodać odniesienia do pliku values.yaml tak aby móc potem za pomocą tego pliku ustawiać opcje podane w punkcie pierwszym. 


## Źródła, pomoce 

- Dokumentacja [Helma](https://helm.sh/docs/)
- Przykładowy tutorial ze stawiania prometeusza i grafany [link](https://semaphoreci.com/blog/prometheus-grafana-kubernetes-helm)