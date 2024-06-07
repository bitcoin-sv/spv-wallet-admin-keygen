# SPV Wallet Admin Keygen

This tool generates public and private key pairs for SPV Wallet applications. 
It can just print those keys or by default store it in the Kubernetes secret.

## Printing Keys

To print the keys, run the following command:

```bash
docker run ${DOCKER_IMAGE}:latest --print --no-k8s
```

## Kubernetes Secret Creation

### connect to kubernetes cluster
To set the keys in kubernetes secret, you need to setup the image to have access to the namespace kubernetes cluster.

You can do this for example by creating a dedicated kubeconfig file and mounting it to the container.
Simplest way to do this is to mount your .kube/config file to the container.

```bash
docker run -v {my/kube/config/file}:/kubeconfig -e KUBECONFIG=/kubeconfig ${DOCKER_IMAGE}:latest
```

### Configure the secret name
By default the secret name is `spv-wallet-keys`.
You can change it by using argument -s or --secret

ℹ️ To configure k8s connection look at the section [connect to kubernetes cluster](#connect-to-kubernetes-cluster)

```bash
docker run ${DOCKER_IMAGE}:latest --secret my-secret-name
```

If you prefer to use environment variables, you can set the `SECRET_NAME` environment variable instead.

```bash
docker run -e SECRET_NAME=my-secret-name ${DOCKER_IMAGE}:latest
```

### Configure the key names
By default the key names are `admin_xpub` and `admin_xpriv`.
You can change it by using arguments -pb and -pv or --xpub-key and --xprv-key respectively.

ℹ️ To configure k8s connection look at the section [connect to kubernetes cluster](#connect-to-kubernetes-cluster)

```bash
docker run ${DOCKER_IMAGE}:latest --xpub-key my-xpub-key-name --xprv-key my-xpriv-key-name
```

If you prefer to use environment variables, you can set the `XPUB_KEY_NAME` and `XPRV_KEY_NAME` environment variables instead.

```bash
docker run -e XPUB_KEY_NAME=my-xpub-key-name -e XPRV_KEY_NAME=my-xpriv-key-name ${DOCKER_IMAGE}:latest
```
