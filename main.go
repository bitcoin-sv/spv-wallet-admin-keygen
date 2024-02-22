package main

import (
	"fmt"
	"os"

	"github.com/bitcoin-sv/spv-wallet-go-client/xpriv"
)

func main() {

	keys, err := xpriv.Generate()

	if err != nil {
		fmt.Println(err)
	}

	xpubKeyName := "xpub_key.txt"
	xprvKeyName := "xprv_key.txt"

	xpubKeyFile, err := os.Create(xpubKeyName)

	if err != nil {
		panic(err)
	}

	defer func(xpubKeyFile *os.File) {
		err := xpubKeyFile.Close()
		if err != nil {
			fmt.Println(err)
		}
	}(xpubKeyFile)

	_, err = xpubKeyFile.WriteString(keys.XPub().String())

	if err != nil {
		panic(err)
	}

	fmt.Println("xpub_key.txt created and written successfully.")

	xprvKeyFile, err := os.Create(xprvKeyName)

	if err != nil {
		panic(err)
	}

	defer func(xprvKeyFile *os.File) {
		err := xprvKeyFile.Close()
		if err != nil {
			fmt.Println(err)
		}
	}(xprvKeyFile)

	_, err = xprvKeyFile.WriteString(keys.XPriv())

	if err != nil {
		panic(err)
	}

	fmt.Println("xprv_key.txt created and written successfully.")
}
