#!/bin/bash

kubectl config set-context --current --namespace=fiszki
kubectl delete service --all
kubectl delete deployment --all
kubectl delete statefulset --all
kubectl delete cronjob --all
kubectl delete networkpolicy --all
