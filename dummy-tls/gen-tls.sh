#!/bin/bash
# Generate self-signed certificate for wallet.example.com

DOMAIN="wallet.example.com"
DAYS=365

# Generate private key
openssl genrsa -out ${DOMAIN}.key 2048

# Generate CSR (Certificate Signing Request)
openssl req -new -key ${DOMAIN}.key -out ${DOMAIN}.csr \
  -subj "/C=US/ST=California/L=San Francisco/O=Example Inc/CN=${DOMAIN}"

# Generate self-signed certificate
openssl x509 -req -days ${DAYS} -in ${DOMAIN}.csr -signkey ${DOMAIN}.key -out ${DOMAIN}.crt

# Generate combined PEM file (sometimes needed)
cat ${DOMAIN}.crt ${DOMAIN}.key > ${DOMAIN}.pem

echo "Generated files:"
ls -la ${DOMAIN}.*
echo ""
echo "Certificate details:"
openssl x509 -in ${DOMAIN}.crt -text -noout | head -20
