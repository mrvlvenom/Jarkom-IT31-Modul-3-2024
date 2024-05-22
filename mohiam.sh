echo 'nameserver 192.232.3.1' > /etc/resolv.conf
apt-get update
apt install isc-dhcp-server -y

# 2
# Client yang melalui Switch1 (House Horkonen) mendapatkan range IP dari [prefix IP].1.14 - [prefix IP].1.28 dan [prefix IP].1.49 - [prefix IP].1.70 (2)
echo 'subnet 192.232.1.0 netmask 255.255.255.0 {
    range 192.232.1.14 192.232.1.28;
    range 192.232.1.49 192.232.1.70;
    option routers 192.232.1.0;
}

subnet 192.232.2.0 netmask 255.255.255.0 {
}

subnet 192.232.3.0 netmask 255.255.255.0 {

}' > /etc/dhcp/dhcpd.conf

# 3
# Client yang melalui Switch2 (House Atreides) mendapatkan range IP dari [prefix IP].2.15 - [prefix IP].2.25 dan [prefix IP].2.200 - [prefix IP].2.210
echo 'subnet 192.232.1.0 netmask 255.255.255.0 {
    range 192.232.1.14 192.232.1.28;
    range 192.232.1.49 192.232.1.70;
    option routers 192.232.1.0;
}

subnet 192.232.2.0 netmask 255.255.255.0 {
    range 192.232.2.15 192.232.2.25;
    range 192.232.2.200 192.232.2.210;
    option routers 192.232.2.0;
}

subnet 192.232.3.0 netmask 255.255.255.0 {
}

subnet 192.232.4.0 netmask 255.255.255.0 {
} ' > /etc/dhcp/dhcpd.conf

# 4
# Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut (4)
netstat -an | grep 67

# 5
# Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3 selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 96 menit (5)
echo 'subnet 192.232.1.0 netmask 255.255.255.0 {
    range 192.232.1.14 192.232.1.28;
    range 192.232.1.49 192.232.1.70;    
    option routers 192.232.1.0;
    option broadcast-address 192.232.1.255;
    option domain-name-servers 192.232.3.1;
    default-lease-time 300; # 5 menit     
    max-lease-time 5220; #87 menit
}

subnet 192.232.2.0 netmask 255.255.255.0 {
    range 192.232.2.15 192.232.2.25;
    range 192.232.2.200 192.232.2.210;
    option routers 192.232.2.0;
    option broadcast-address 192.232.2.255;
    option domain-name-servers 192.232.3.1;
    default-lease-time 1200; #20 menit
    max-lease-time 5220; #87 menit
}

subnet 192.232.3.0 netmask 255.255.255.0 {
}

subnet 192.232.4.0 netmask 255.255.255.0 {
}

host vladimir {
    hardware ethernet 8e:c1:16:c2:6d:4b;
    fixed-address 192.232.1.1;
}

host Rabban {
    hardware ethernet 7a:e7:1c:d2:ae:44;
    fixed-address 192.232.1.2;
}

host Feyd {
    hardware ethernet 8a:02:fd:bb:05:be;
    fixed-address 192.232.1.3;
}

host Leto {
    hardware ethernet 9e:d5:2c:df:39:32;
    fixed-address 192.232.2.1;
}

host Duncan {
    hardware ethernet da:cc:d9:29:59:e8;
    fixed-address 192.232.2.2;
}

host Jessica {
    hardware ethernet 8a:31:c6:e6:a2:7b;
    fixed-address 192.232.2.3;
}' > /etc/dhcp/dhcpd.conf

echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

service isc-dhcp-server start