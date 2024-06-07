# SPV Wallet Admin Keygen

This tool generates public and private key pairs for bitcoin-sv (SPV-Wallet) applications. The generated keys are stored in separate files (xpub_key.txt and xprv_key.txt).

## Documentation

For in-depth information and guidance, please refer to the [SPV Wallet Documentation](https://bsvblockchain.gitbook.io/docs).
## Usage

### File with keys generation

`go run main.go`
It will create two files:

_xpub_key.txt_: Contains the public key.

_xprv_key.txt_: Contains the private key.

### Local script usage

1. Build the binary file:
```bash
CGO_ENABLED=0 go build -ldflags="-s -w" -v -o /generator
```
2. Run script:
```bash
./keygen.sh
```

ℹ️ Use the option -h to see available options for the script.
```bash
./keygen.sh -h
```

### Run locally from local docker build

1. Build the docker image:
```bash
docker build --build-arg build_in_docker=true -t spv-wallet-admin-keygen:local .
```
2. Run the docker container:
```bash
docker run -v ./my-kubeconfig:/kubeconfig -e KUBECONFIG=/kubeconfig spv-wallet-admin-keygen:local
```
- ./my-kubeconfig: Path to the kubeconfig file that will setup connection to k8s cluster.
- you can pass any parameter to the docker run command as you would do with the script.

## License

This project is licensed under the MIT License.
