# myvault
Vault sandbox for testing


# Consul CLI from server host
export CONSUL_HTTP_ADDR=localhost:443
export CONSUL_HTTP_SSL=true
export CONSUL_HTTP_SSL_VERIFY=false
export CONSUL_CACERT=/etc/consul/ssl/ca.cert
export CONSUL_TLS_SERVER_NAME=server.dc1.consul
export CONSUL_CLIENT_CERT=/etc/consul/ssl/consul.cert
export CONSUL_CLIENT_KEY=/etc/consul/ssl/consul.key


# Vault CLI from server host
export VAULT_ADDR='https://server.dc1.vault:8200'
export VAULT_CAPATH=/etc/vault.d/ssl/ca.cert
export CONSUL_HTTP_ADDR=server.dc1.consul:443
export CONSUL_HTTP_SSL=true
export CONSUL_HTTP_SSL_VERIFY=false
export CONSUL_CACERT=/etc/consul/ssl/ca.cert
export CONSUL_TLS_SERVER_NAME=server.dc1.consul

# Vault CLI through load balancer
export VAULT_ADDR='https://bradvault.aws.bradandmarsha.com'
