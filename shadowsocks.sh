wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-go.sh
chmod +x shadowsocks-go.sh

./shadowsocks-go.sh 2>&1 | tee shadowsocks-go.log

vi /etc/shadowsocks/config.json

{
    "port_password":{
         "9000":"123123"
    },
    "method":"chacha20",
    "timeout":600
}

/etc/init.d/shadowsocks restart
