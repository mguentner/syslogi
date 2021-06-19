package main

import (
	"log"
	"fmt"

	"gopkg.in/mcuadros/go-syslog.v2"
	flag "github.com/spf13/pflag"
)

var (
	listenAddress string
)

func main() {
	flag.StringVar(&listenAddress, "listen", "127.0.0.1:514", "UDP listen address") 
	flag.Parse()

	if listenAddress == "" {
		log.Fatalf("Please provide a listenAddress")
	}

	channel := make(syslog.LogPartsChannel)
	handler := syslog.NewChannelHandler(channel)

	server := syslog.NewServer()
	server.SetFormat(syslog.RFC3164)
	server.SetHandler(handler)
	err := server.ListenUDP(listenAddress)
	if err != nil {
		log.Fatalln(err)
	}

	server.Boot()

	go func(channel syslog.LogPartsChannel) {
		for logParts := range channel {
			fmt.Println(logParts)
		}
	}(channel)

	server.Wait()
}
