#!/bin/bash
mkdir $HOME/.streamrDocker_2
mkdir $HOME/.streamrDocker_3


cfg_node() {
expect <<END
    set timeout 300
    spawn docker run -it --rm -v $(cd ~/.$1; pwd):/root/.streamr streamr/broker-node:testnet bin/config-wizard
  	expect "Do you want to generate"
  	send -- "\n"
  	expect "We strongly recommend"
  	send -- "y\n"
  	expect "Select the plugins"
  	send -- "a\n"
  	expect "Provide a port for the websocket"
  	send -- "$2\n"
  	expect "Provide a port for the mqtt"
  	send -- "$3\n"
  	expect "Provide a port for the publishHttp"
  	send -- "$4\n"
  	expect "Select a path to store"
  	send -- "\n"
  	expect eof
  	spawn docker run -it --restart=always --name=$1 -d -p $2:$2 -p $4:$4 -p $3:$3 -v $(cd ~/.$1; pwd):/root/.streamr streamr/broker-node:testnet
  	expect eof
END
}

cfg_node streamrDocker_2 12346 12349 12352
cfg_node streamrDocker_3 12347 12350 12353





