# Laboratoria 4 - InitContainery, Probiness i te sprawy

## Opis czynności i procedury testowe, czyli skąd wiem że działa

### Część na 3.0  i 3.5

Tutaj sprawdzenie polega na obserwowaniu aktywynych podów - jeśli jest ok
to pod deploymentu powinien po kilkunastu sekundach dostać status ready.

Na początku jest tak:
```
▶ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
backend-deployment-784c58d6b7-tnssw   0/1     Running   0          7s
```

A jak dostanie sygnał ready to będzie tak:

```
▶ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
backend-deployment-784c58d6b7-tnssw   1/1     Running   0          25s
```

### Część na 4.0

W tej części jest stosunkowo proste sprawdzenie, wystarczy usunąć wolument bazy danych i sprawdzić czy przy tworzeniu statefulseta wgrało nam dane z backupa. Z uwagi że zadanie z Cron'em wymagało robienia backupów cyklicznie to też polecenie wybiera najnowszy backup i kopiuje go do wolumenu bazy danych. W logach wygląda to tak:

```No backups found.```

jeśli nie było backupów, albo:

```Reading most recent backup [ 2024-05-19_02-00-01 ] into DB.``` 

jeśli jakiś backup był.

W tym miejscu warto zaznaczyć że całość tej procedury i tak jest trochę udawaniem, bo żeby naprawdę wgrać backup to dobrze byłoby użyć ```mongorestore```.

### Część na 5.0

Z tą częścią było ciężko bo minikube jest jaki jest.

Najpierw trzeba uruchomić minikuba z wtyczką Calico do obsługi sieci.

```
▶ minikube delete
▶ minikube start --network-plugin=cni --cni=calico
▶ watch kubectl get pods -l k8s-app=calico-node -A
```

jeśli wszystko się udało powinno pojawić się coś takiego:

```
NAMESPACE     NAME                READY   STATUS    RESTARTS   AGE
kube-system   calico-node-rc98z   1/1     Running   0          30s
```

Te kroki całkowicie zabijają całego minikuba, więc na przykład namespace'y
są usunięte i trzeba zrobić całość od nowa (jak na labach 2).

Teraz można przejść do sprawdzania netpoli. Dla testów networkPolicy nałożyłem na backend bo łatwiej sprawdzić czy działa - łatwiej jest curlować stronę http niż próbować łączyć się do DB co jest męczące albo pingować sam serwer i nie być do końca pewnym czy jeśli odpowiada to jest dobrze czy źle (nie do końca ufam minikubowi - co jeśli akurat tutaj ktoś użył zamiast DROP to REJECT i pinga nam da ale już treści nie).

Najpierw trzeba ustalić IP serwisu backendu w klastrze:

```
▶ kubectl get svc
NAME                      TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)           AGE
fiszki-backend-nodeport   NodePort    10.108.234.0   <none>        27017:30080/TCP   18m
```

Teraz z poziomu kontenera w namespace'ie próbuję pobrać stronę backendu, najławiej wgetem, bo busybox nie ma cURLa (mega smuteczek). Tutaj zrobiłem to z dbdump-inspectora:

```
▶ kubectl exec dbdump-inspector -- wget -O - 10.108.234.0:27017
Connecting to 10.108.234.0:27017 (10.108.234.0:27017)
writing to stdout
-                    100% |********************************|   947  0:00:00 ETA
written to stdout

    <!DOCTYPE html>
    <html>
    <head>
    <link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swagger-ui-dist@5.9.0/swagger-ui.css">
    <link rel="shortcut icon" href="https://fastapi.tiangolo.com/img/favicon.png">
    <title>Devops labs api - Swagger UI</title>
```

Teraz zrobimy to samo z poda poza namespacem. Do tego zrobiłem poda *networktest* w namespace'ie default.

```
▶ kubectl -n=default exec networktest -- wget -O - 10.108.234.0:27017
Connecting to 10.108.234.0:27017 (10.108.234.0:27017)
```

No i nie ma odpowiedzi - nasza blokada działa.



# ♫ To już jest koniec, nie ma już nic ♫