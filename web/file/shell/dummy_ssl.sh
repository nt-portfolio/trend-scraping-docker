#!/bin/bash
set -ux

# サーバのホスト名
SSL_HOST_NAME="192.168.33.21"

# サーバ証明書や秘密鍵を保存するディレクトリ
SSL_PKI_DIR="/etc/pki/tls"

# 証明書の所有者の情報
SERVER_SUBJECT="/C=JP/ST=Tokyo/L=Shinjuku-ku/O=Neko Ltd./OU=Dev/CN=${SSL_HOST_NAME}"

# 証明書の有効期間(10年)
DAYS=3650

mkdir -p ${SSL_PKI_DIR}

openssl genrsa -out ${SSL_PKI_DIR}/apachessl.key 2048 || exit 1
openssl req -new -key ${SSL_PKI_DIR}/apachessl.key -out ${SSL_PKI_DIR}/apachessl.csr -subj "${SERVER_SUBJECT}" || exit 1

openssl x509 -in ${SSL_PKI_DIR}/apachessl.csr -days ${DAYS} -req -signkey ${SSL_PKI_DIR}/apachessl.key -out ${SSL_PKI_DIR}/apachessl.crt || exit 1