#!/bin/bash
kubectl get pods --all-namespaces | grep pod-name | awk '{print $2 " --namespace=" $1}' | xargs kubectl delete pod
