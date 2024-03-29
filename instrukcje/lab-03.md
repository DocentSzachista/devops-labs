# Laboratorium 3 - O storage'u słów kilka(dziesiąt)

## Wstęp
No to już udało się nam zdeployować aplikację, coś nawet otworzyliśmy ruch na świat, oraz podpieliśmy aplikację do bazy danych. Także teraz przydałoby się te dane jakoś przetrzymywać

## PersistentVolume i StatefullSet

## Przykład




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
Może się zdarzyć tak, że ktoś nieopatrznie będzie chciał skorzystać z waszego PersistentVolume, albo ktoś źle skonfiguruje deployment i logi będzie zapisywał w waszym przydzielonym storage'u. Zdarza się, jako devops zazwyczaj będzie współpracować z ludźmi, i będziecie poprawiać ich błędy albo oni wasze. (Jak sądzicie skąd Tomek mnie wytrzasnął? XD). 

Co należy zrobić?
- W PersistentVolume dodać po prostu jedną opcję a konkretnie `claimRef` z określeniem następujących rzeczy:
    - nazwy `PersistentVolumeClaim`
    - namespace'a gdzie się ten `PersistentVolumeClaim znajduje`


### 4.0 - Poprawienie grzechów z lab 3 
Należy utworzyć Statefull Set zamiast Deploymentu z bazą danych 
Czyli inaczej co trzeba zrobić: 
- Wejść na stronę dokumentacji [StatefullSet](https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/) i przekopiować definicję StatefullSet'u.
- Zmienić nazwy w metadanych na nazwy znaczące, na przykład `MongoStatefullSet` (to jest tylko przykład, błagam, nie nazywajcie wszyscy tak samo xD). 
- Podmienić obraz z nginx'a na obraz mongo oraz podmienić:
    - wolumen na taki, gdzie zapisywane są dane
    - udostępniany port
    - Podmienić `volumeClaimTemplate` a konkretnie można mu zmienić nazwę Claim'a oraz wymagania pamięci na `500Mi`

### 4.5 Stworzenie config mapy do połączenia się z baza danych.

### 5.0 A słyszeli może państwo o backup'ach?

