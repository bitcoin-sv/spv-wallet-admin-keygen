# Bux Key Generator
This tool generates public and private key pairs for BuxOrg applications. The generated keys are stored in separate files (xpub_key.txt and xprv_key.txt).

## Usage
Run the generator script to generate keys:

`./generator`
The script will create two files:

_xpub_key.txt_: Contains the public key.

_xprv_key.txt_: Contains the private key.


Optionally, you can use the provided `set_secret.sh` script to create a Kubernetes secret with the generated keys:

You can customize these by setting environment variables `SECRET_NAME`, `XPUB_KEY_NAME`, and `XPRV_KEY_NAME` before running the script.

## Docker Usage
This tool is available as a Docker image to facilitate key generation and secret creation in a containerized environment.

### Build the Docker image:

`docker build -t bux-key-generator` -
Run the Docker container to generate keys:

`docker run -v "$(pwd):/src" bux-key-generator` -
Optionally, run the Docker container to create a Kubernetes secret:

`docker run -v "$(pwd):/src" -e SECRET_NAME=my-secret -e XPUB_KEY_NAME=my-xpub -e XPRV_KEY_NAME=my-xpriv bux-key-generator` -
Replace _my-secret_, _my-xpub_, and _my-xpriv_ with your desired secret and key names.

### Kubernetes Secret Creation
If you want to create a Kubernetes secret using the provided set_secret.sh script, make sure to set the required environment variables:

`SECRET_NAME`: The name of the secret.
`XPUB_KEY_NAME`: The name of the key storing the public key.
`XPRV_KEY_NAME`: The name of the key storing the private key.

### Environment Variables
The Docker image accepts the following environment variables:

`SECRET_NAME`: (Default: _bux-keys_) The name of the Kubernetes secret.

`XPUB_KEY_NAME`: (Default: _admin_xpub_) The name of the key storing the public key.

`XPRV_KEY_NAME`: (Default: _admin_xpriv_) The name of the key storing the private key.

Set these environment variables when running the Docker container to customize the secret and key names.


### License
This project is licensed under the MIT License.
