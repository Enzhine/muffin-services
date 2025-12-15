#!/bin/bash

cat > tls-secret.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: $1
type: kubernetes.io/tls
data:
  tls.crt: $(base64 -w0 wallet.example.com.crt)
  tls.key: $(base64 -w0 wallet.example.com.key)
EOF
