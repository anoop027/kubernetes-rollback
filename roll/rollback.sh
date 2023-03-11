#!/bin/bash
deployments=$(kubectl get deployments --no-headers -o custom-columns=":metadata.name" | grep -i "my-client-dep1")
echo "====== $(date) ======"
for deployment in ${deployments}; do
  if ! kubectl rollout status deployment ${deployment} --timeout=10s 1>/dev/null 2>&1; then
    echo "error -- rolling back"
    kubectl rollout undo deployment ${deployment}
  else
    echo "Ok: ${deployment}"
  fi
done

