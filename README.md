# Jarkom-IT31-Modul-3-2024

| No | Nama | NRP |
|---|---|---|
| 1 | M. Januar Eko Wicaksono | 50272221006 |
| 2 | SUbkhan Mas Udi | 50272221044 |

## SOAL SHIFT MODUL 3
### TOPOLOGI
![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/topologi_soal.png)

### CONFIGURE
1. Arakis (Router(DHCP Relay))
```bash
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.232.1.0
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.232.2.0
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.232.3.0
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 192.232.4.0
	netmask 255.255.255.0
```

2. Mohiam (DHCP Server)
```bash
auto eth0
iface eth0 inet static
	address 192.232.3.2
	netmask 255.255.255.0
	gateway 192.232.3.0
```

3. Irulan (DNS Server)
```bash
auto eth0
iface eth0 inet static
	address 192.232.3.1
	netmask 255.255.255.0
	gateway 192.232.3.0
```

4. Chani (Database Server)
```bash
auto eth0
iface eth0 inet static
	address 192.232.4.1
	netmask 255.255.255.0
	gateway 192.232.4.0
```

5. Stilgar (Load Balancer)
```bash
auto eth0
iface eth0 inet static
	address 192.232.4.2
	netmask 255.255.255.0
	gateway 192.232.4.0
```

6. Leto (Laravel Worker)
```bash
auto eth0
iface eth0 inet static
	address 192.232.2.1
	netmask 255.255.255.0
	gateway 192.232.2.0
```

7. Duncan (Laravel Worker)
```bash
auto eth0
iface eth0 inet static
	address 192.232.2.2
	netmask 255.255.255.0
	gateway 192.232.2.0
```

8. Jessica (Laravel Worker)
```bash
auto eth0
iface eth0 inet static
	address 192.232.2.3
	netmask 255.255.255.0
	gateway 192.232.2.0
```

9. Vladimir (PHP Worker)
```bash
auto eth0
iface eth0 inet static
	address 192.232.1.1
	netmask 255.255.255.0
	gateway 192.232.1.0
```

10. Rabban (PHP Worker)
```bash
auto eth0
iface eth0 inet static
	address 192.232.1.2
	netmask 255.255.255.0
	gateway 192.232.1.0
```

11. Feyd (PHP Worker)
```bash
auto eth0
iface eth0 inet static
	address 192.232.1.3
	netmask 255.255.255.0
	gateway 192.232.1.0
```

12. Dmitri (Client)
```bash
auto eth0
iface eth0 inet dhcp
```

13. Paul (Client)
```bash
auto eth0
iface eth0 inet dhcp
```

### SETUP 
Sebelum melanjutkan soal, alangkah baiknya kita setup tiap worker terlebih dahulu pada "/root/.bachrc". Agar tidak selalu menginstall ulang, ketika di refresh/di close.

1. Arakis (Router(DHCP Relay))
```bash
apt-get update
apt install isc-dhcp-relay -y
```

2. Mohiam (DHCP Server)
```bash
echo 'nameserver 192.232.3.1' > /etc/resolv.conf # IP Irulan  
apt-get update
apt install isc-dhcp-server -y
```

3. Irulan (DNS Server)
```bash
echo 'nameserver 192.168.122.1' > /etc/resolv.conf 
apt-get update
apt-get install bind9 -y  
```

4. Chani (Database Server)
```bash
echo 'nameserver 192.232.3.1' > /etc/resolv.conf #IP Irulan
apt-get update
apt-get install mariadb-server -y
service mysql start

Lalu jangan lupa untuk mengganti [bind-address] pada file /etc/mysql/mariadb.conf.d/50-server.cnf menjadi 0.0.0.0 dan jangan lupa untuk melakukan restart mysql kembali
```

5. Stilgar (Load Balancer)
```bash
echo 'nameserver 192.232.3.1' > /etc/resolv.conf #IP Irulan
apt-get update
apt-get install apache2-utils -y
apt-get install nginx -y
apt-get install lynx -y

service nginx start
```

6. Leto, Duncan, Jessica (Laravel Worker)
```bash
echo 'nameserver 192.232.3.1' > /etc/resolv.conf
apt-get update
apt-get install lynx -y
apt-get install mariadb-client -y
# Test connection from worker to database
# mariadb --host=192.246.3.2 --port=3306  --user=kelompokit31 --password=passwordit26 dbkelompokit31 -e "SHOW DATABASES;"
apt-get install -y lsb-release ca-certificates a   apt-transport-https software-properties-common gnupg2
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
apt-get update
apt-get install php8.0-mbstring php8.0-xml php8.0-cli   php8.0-common php8.0-intl php8.0-opcache php8.0-readline php8.0-mysql php8.0-fpm php8.0-curl unzip wget -y
apt-get install nginx -y

service nginx start
service php8.0-fpm start
```

7. Vladimir, Rabban, Feyd (PHP Worker)
```bash
echo 'nameserver 192.232.3.1' > /etc/resolv.conf #IP Irulan
apt-get update
apt-get install nginx -y
apt-get install wget -y
apt-get install unzip -y
apt-get install lynx -y
apt-get install htop -y
apt-get install apache2-utils -y
apt-get install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip -y

service nginx start
service php7.3-fpm start
```

12. Dmitri & Paul (Client)
```bash
apt update
apt install lynx -y
apt install htop -y
apt install apache2-utils -y
apt-get install jq -y
```

### PROBLEM
---
Planet Caladan sedang mengalami krisis karena kehabisan spice, klan atreides berencana untuk melakukan eksplorasi ke planet arakis dipimpin oleh duke leto mereka meregister domain name atreides.yyy.com untuk worker Laravel mengarah pada Leto Atreides . Namun ternyata tidak hanya klan atreides yang berusaha melakukan eksplorasi, Klan harkonen sudah mendaftarkan domain name harkonen.yyy.com untuk worker PHP (0) mengarah pada Vladimir Harkonen

Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.(1)

### SOLUTION
---
Untuk problem ini kita lakukan konfigurasi pada dns server. Pertama-tama kita ubah terlebih dahulu nameserver pada client, menggunakan IP irulan:
```bash
echo 'nameserver 192.232.3.1 // IP Irulan' > /etc/bind/resolv.conf
```

Kemudian kita gunakan perintah dalam bash untuk menjalankan semua perintah pada soal diatas, dan bash tersebut dijalankan di DNS Server yaitu Irulan:
```bash
echo 'zone "atreides.it31.com" {
    type master;
    file "/etc/bind/sites/atreides.it31.com";
};

zone "harkonen.it31.com" {
    type master;
    file "/etc/bind/sites/harkonen.it31.com";
};

zone "1.232.192.in-addr.arpa" {
    type master;
    file "/etc/bind/sites/1.232.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

mkdir -p /etc/bind/sites
cp /etc/bind/db.local /etc/bind/sites/atreides.it31.com
cp /etc/bind/db.local /etc/bind/sites/harkonen.it31.com
cp /etc/bind/db.local /etc/bind/sites/1.232.192.in-addr.arpa

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     atreides.it31.com. root.atreides.it31.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      atreides.it31.com.
@       IN      A       192.232.2.1     ; IP Leto
www     IN      CNAME   atreides.it31.com.' > /etc/bind/sites/atreides.it31.com

echo '
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     harkonen.it31.com. root.harkonen.it31.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      harkonen.it31.com.
@       IN      A       192.232.1.1     ; IP Vladimir
www     IN      CNAME   harkonen.it31.com.' > /etc/bind/sites/harkonen.it31.com

echo 'options {
      directory "/var/cache/bind";

      forwarders {
              192.168.122.1;
      };

      // dnssec-validation auto;
      allow-query{any;};
      auth-nxdomain no;    # conform to RFC1035
      listen-on-v6 { any; };
}; ' >/etc/bind/named.conf.options

service bind9 start
```
Kemudian dijalankan, dan kita test pada setiap client yaitu Dmitri dan Paul, dan hasilnya seperti berikut:
a. Dmitri (Client 1)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no1_c1.png)

b. Paul (CLient 2)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no1_c2.png)

### CASE 1
Kemudian, karena masih banyak spice yang harus dikumpulkan, bantulah para aterides untuk bersaing dengan harkonen dengan kriteria berikut.:

### PROBLEM
---
1. Semua CLIENT harus menggunakan konfigurasi dari DHCP Server.
2. Client yang melalui House Harkonen mendapatkan range IP dari [prefix IP].1.14 - [prefix IP].1.28 dan [prefix IP].1.49 - [prefix IP].1.70 (2).

### SOLUTION
---
1. Untuk problem pertama ini kita ubah dulu konfigurasi dari worker client dengan:
```bash
echo 'nameserver 192.232.3.1 // IP Irulan' > /etc/bind/resolv.conf
```
2. Kemudian Setup dhcp server, dns server, dan dhcp relay sesuai dengan modul sebelumnya.
[modul3(dhcp).](https://github.com/arsitektur-jaringan-komputer/Modul-Jarkom/tree/master/Modul-3/DHCP#123-konfigurasi-dhcp-relay)

Setelah itu, jalankan bash berikut di mohiam untuk setup problem no.2:
```bash
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
```
- Testing
a. Dmitri (Client 1)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/ip_a_dmitri.png)

### PROBLEM
---
3. Client yang melalui House Atreides mendapatkan range IP dari [prefix IP].2.15 - [prefix IP].2.25 dan [prefix IP].2 .200 - [prefix IP].2.210 (3)

### SOLUTION
---
3. Untuk problem ini kita tambahkan script bash berikut di mohiam untuk setup problem no.3:
```bash
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
```
- Testing
a. Paul (Client 2)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/ip_a_paul.png)

### PROBLEM
---
4. Client mendapatkan DNS dari Princess Irulan dan dapat terhubung dengan internet melalui DNS tersebut (4)

### SOLUTION
---
4. Untuk problem ini kita kita akan menambahkan beberapa konfigurasi seperti 'option broadcast-address' dan 'option domain-name-server' agar dapat DNS yang telah disiapkan sebelumnya dapat digunakan:

a. Script
```bash
subnet 192.232.1.0 netmask 255.255.255.0 {
    ...
    option broadcast-address 192.232.1.255;
    option domain-name-servers 192.232.3.1; 
    ...
}

subnet 192.232.2.0 netmask 255.255.255.0 {
    option broadcast-address 192.232.2.255;
    option domain-name-servers 192.232.3.1;
} 
```

b. Gunakan Script bash berikut untuk menambahkan pada script bash sebelumnya:
a. Script
```bash
echo 'subnet 192.232.1.0 netmask 255.255.255.0 {
	range 192.232.1.16 192.232.1.32;
    range 192.232.1.14 192.232.1.28;
    range 192.232.1.49 192.232.1.70;
    option routers 192.232.1.0;
    option broadcast-address 192.232.1.255;
    option domain-name-servers 192.232.3.1;
}

subnet 192.232.2.0 netmask 255.255.255.0 {
    range 192.232.2.15 192.232.2.25;
    range 192.232.2.200 192.232.2.210;
    option routers 192.232.2.0;
    option broadcast-address 192.232.2.255;
    option domain-name-servers 192.232.3.1;
}

subnet 192.232.3.0 netmask 255.255.255.0 {
}

subnet 192.232.4.0 netmask 255.255.255.0 {
} ' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server start
```

Terakhir jangan lupa untuk restart seluruh client agar dapat melakukan leasing IP dari DHCP Server

Kemudian hasilnya akan seperti berikut:

a. Dmitri (Client 1)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no4_c1.png)

b. Paul (CLient 2)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no4_c2.png)

### PROBLEM
---
5. Durasi DHCP server meminjamkan alamat IP kepada Client yang melalui House Harkonen selama 5 menit sedangkan pada client yang melalui House Atreides selama 20 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 87 menit (5)
*house == switch

### SOLUTION
---
5. Untuk problem ini kita Kita perlu menggunakan bantuan fungsi "default-lease-time" dan "max-lease-team" dimana satuannya adalah detik.

Karena pada switch1 dapat meminjamkan IP selama 5 Menit dan Switch2 dapat meminjamkan IP selama 20 Menit. Sehingga pada Switch1 membutuhkan waktu 300 s dan Switch2 membutuhkan waktu 1200 s dan untuk "max-lease-time" nya adalah 87 menit dimana akan menjadi 5220 s

Selanjutnya kita perlu menambahkan beberapa konfigurasi baru untuk mengatur leasing time pada switch1 dan switch2 sesuai dengan aturan soal 5. Kita dapat menjalankan command berikut pada DHCP Server dengan menambahkan script bash berikut di mohiam untuk setup problem no.5:
```bash
# 5
# Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch1 selama 5 menit sedangkan pada client yang melalui Switch2 selama 12 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 96 menit (5)
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
```
Kemudian hasilnya akan seperti berikut:

a. Dmitri (Client 1)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no5_c1.png)

b. Paul (CLient 2)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no5_c2.png)

### CASE 2
Seiring berjalannya waktu kondisi semakin memanas, untuk bersiap perang. Klan Harkonen melakukan deployment sebagai berikut

### PROBLEM
---
1. Vladimir Harkonen memerintahkan setiap worker(harkonen) PHP, untuk melakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3. (6)
### SOLUTION
---
1. Untuk problem ini kita perlu untuk melakukan setup terlebih dahulu pada seluruh PHP Worker pada setup diatas. Jika sudah, silahkan untuk melakukan konfigurasi tambahan sebagai berikut untuk melakukan download dan unzip menggunakan command wget.
```bash
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1lmnXJUbyx1JDt2OA5z_1dEowxozfkn30' -O /var/www/harkonen.it31.com
unzip -o /var/www/harkonen.it31.com -d /var/www/
rm /var/www/harkonen.it31.com
mv /var/www/modul-3 /var/www/harkonen.it31.com
```

Setelah meng-unzip file yang sudah didownload, sekarang kita bisa melakukan konfigurasi nginx pada bash berikut:
```bash
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/harkonen.it31.com
ln -s /etc/nginx/sites-available/harkonen.it31.com /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

echo 'server {
    listen 80;
    server_name _;

    root /var/www/harkonen.it31.com;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.3-fpm.sock;  # Sesuaikan versi PHP dan socket
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}' > /etc/nginx/sites-available/harkonen.it31.com

service nginx restart
```
Jalanin Perintah "lynx localhost" pada masing-masing client dan hasilnya akan sebagai berikut:

a. Vladimir:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no6_p1.png)

b. Rabban:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no6_p2.png)

c. Feyd:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no6_p3.png)

### PROBLEM
---
2. Aturlah agar Stilgar dari fremen dapat dapat bekerja sama dengan maksimal, lalu lakukan testing dengan 5000 request dan 150 request/second. (7)
### SOLUTION
---
2. Untuk problem ini kita perlu untuk melakukan setup terlebih dahulu. Setelah melakukan konfigurasi diatas, sekarang lakukan konfigurasi Load Balancing pada node Stilgar sebagai berikut:

a. Sebelum melakukan setup soal ini. Buka kembali Node DNS Server dan arahkan domain tersebut pada IP Stilgar (Worker Load Balancer)
```bash
echo 'nameserver 192.232.3.1' > /etc/resolv.conf
apt-get update
apt install bind9 -y

# Temporary
echo 'zone "atreides.it31.com" {
    type master;
    file "/etc/bind/sites/atreides.it31.com";
};

zone "harkonen.it31.com.com" {
    type master;
    file "/etc/bind/sites/harkonen.it31.com.com";
};

zone "1.232.192.in-addr.arpa" {
    type master;
    file "/etc/bind/sites/1.232.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

mkdir -p /etc/bind/sites
cp /etc/bind/db.local /etc/bind/sites/atreides.it31.com
cp /etc/bind/db.local /etc/bind/sites/harkonen.it31.com.com
cp /etc/bind/db.local /etc/bind/sites/1.232.192.in-addr.arpa

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     atreides.it31.com. root.atreides.it31.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      atreides.it31.com.
@       IN      A       192.232.4.2     
www     IN      CNAME   atreides.it31.com.' > /etc/bind/sites/atreides.it31.com

echo '
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     harkonen.it31.com.com. root.harkonen.it31.com.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      harkonen.it31.com.com.
@       IN      A       192.232.4.2     
www     IN      CNAME   harkonen.it31.com.com.' > /etc/bind/sites/harkonen.it31.com.com

echo '
; BIND reverse data file for local loopback interface
;
$TTL    604800
@       IN      SOA     atreides.it31.com. root.atreides.it31.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      atreides.it31.com.
1       IN      PTR     atreides.it31.com.' > /etc/bind/sites/1.232.192.in-addr.arpa

echo 'options {
      directory "/var/cache/bind";

      forwarders {
              192.168.122.1;
      };

      // dnssec-validation auto;
      allow-query{any;};
      auth-nxdomain no;    # conform to RFC1035
      listen-on-v6 { any; };
}; ' >/etc/bind/named.conf.options

service bind9 start
```

b. Kemudian kembali ke node Stilgar (Load Balancer) dan lakukan konfigurasi pada nginx sebagai berikut:
```bash
echo 'nameserver 192.232.3.1' > /etc/resolv.conf

# Setup
apt-get update
apt-get install apache2-utils -y
apt-get install nginx -y
apt-get install lynx -y

service nginx start

# Copy file nginx default
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php

# nginx configuration
echo ' upstream worker {
    server 192.248.1.1;
    server 192.248.1.2;
    server 192.248.1.3;
}

server {
    listen 80;
    server_name harkonen.it31.com www.harkonen.it31.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;
    }
} ' > /etc/nginx/sites-available/lb_php

ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

# restart nginx
service nginx restart
```
c. Setelah itu, Jalankan perintah berikut pada tiap client (Dmitri dan Paul):
```bash
ab -n 5000 -c 150 http://www.harkonen.it31.com/
```

Dan hasilnya sebagai berikut:

a. Dmitri:
Dan waktu yang dihasilkan adalah Requests per second: 2238.62 [#/sec] (mean) serta yang dibutuhkan adalah sebagai berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no7_c1.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no7_c1a.png)

b. Paul:
Dan waktu yang dihasilkan adalah Requests per second: 1238.16 [#/sec] (mean) serta yang dibutuhkan adalah sebagai berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no7_c2.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no7_c2a.png)

### PROBLEM
---
3. Karena diminta untuk menuliskan peta tercepat menuju spice, buatlah analisis hasil testing dengan 500 request dan 50 request/second masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut:
a. Nama Algoritma Load Balancer
b. Report hasil testing pada Apache Benchmark
c. Grafik request per second untuk masing masing algoritma. 
d. Analisis (8)

### SOLUTION
---
3. Untuk problem ini kita perlu untuk melakukan setup terlebih dahulu. Setelah melakukan konfigurasi diatas, sekarang lakukan konfigurasi Load Balancing pada node Stilgar sebagai berikut, kurang lebih sama seperti soal sebelumnya:

a. Sebelum melakukan setup soal ini. Buka kembali Node DNS Server dan arahkan domain tersebut pada IP Stilgar (Worker Load Balancer)
```bash
service nginx start

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php

mkdir /etc/nginx/supersecret
htpasswd -c -b /etc/nginx/supersecret/.htpasswd secmart kcksit31


echo '
    upstream worker { # (ip_hash, least_conn, hash $request_uri consistent)
    server 192.232.1.1;
    server 192.232.1.1;
    server 192.232.1.2;
}
    upstream roundrobin_worker {
        server 192.232.1.1;
        server 192.232.1.2;
        server 192.232.1.3;
}

    upstream leastconn_worker {
        least_conn;
        server 192.232.1.1;
        server 192.232.1.2;
        server 192.232.1.3;
}

    upstream weightedrr_worker {
        server 192.232.1.1 weight=3;
        server 192.232.1.2 weight=2;
        server 192.232.1.3 weight=1;
}

    upstream iphash_worker {
        ip_hash;
        server 192.232.1.1;
        server 192.232.1.2;
        server 192.232.1.3;
}

    upstream hash_worker {
        hash $request_uri consistent;
        server 192.232.1.1;
        server 192.232.1.2;
        server 192.232.1.3;
}

server {
    listen 80;
    server_name harkonen.it31.com www.harkonen.it31.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/supersecret/htpasswd;
    }
    location /roundrobin {
        proxy_pass http://roundrobin_worker;
    }
    location /leastconn {
        proxy_pass http://leastconn_worker;
    }
    location /weightedrr {
        proxy_pass http://weightedrr_worker;
    }
    location /iphash {
        proxy_pass http://iphash_worker;
    }
    location /hash {
        proxy_pass http://hash_worker;
    }
}

 server {
	listen 80;
	root /var/www/html;
	index index.html index.htm index.nginx-debian.html;

	server_name _;

        location / {
                allow 192.232.1.27;
                allow 192.232.1.67;
                allow 192.232.2.203;
                allow 192.232.2.207;
                deny all;
                proxy_pass http://worker;
                auth_basic "Restricted Access";
                auth_basic_user_file /etc/nginx/supersecret/.htpasswd;
        }

	location /dune {
		proxy_pass https://www.dunemovie.com.au/;
		proxy_set_header Host www.dunemovie.com.au;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme;
        }
} ' > /etc/nginx/sites-available/lb_php

ln -sf /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/

if [ -f /etc/nginx/sites-enabled/default ]; then
    rm /etc/nginx/sites-enabled/default
fi

service nginx restart
```

b. Kemudian kita coba cek satu persatu tiap algoritma. Disini saya menggunakan 4 algortima yaitu:
1. Round Robin
```bash
ab -n 500 -c 50 http://www.harkonen.it31.com/roundrobin/
```
Dan hasilnya seperti berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no8_c1RR.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_no8_c1RR.png)

2. Least Connection
```bash
ab -n 500 -c 50 http://www.harkonen.it31.com/leastconn/
```
Dan hasilnya seperti berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no8_c1LS.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_no8_c1LC.png)

3. Weighted Round Robin
```bash
ab -n 500 -c 50 http://www.harkonen.it31.com/weightedrr/
```
Dan hasilnya seperti berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no8_c1WR.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_no8_c1WR.png)

4. IP Hash
```bash
ab -n 500 -c 50 http://www.harkonen.it31.com/iphash/
```
Dan hasilnya seperti berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no8_c1IH.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_no8_c1IH.png)

c. Setelah itu, kita analisis menggunakan grafik:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_no8_grafik.png)

### PROBLEM
---
4. Dengan menggunakan algoritma Least-Connection, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 1000 request dengan 10 request/second, kemudian tambahkan grafiknya pada peta. (9)

### SOLUTION
---
4. Sebelum mengerjakan perlu untuk melakukan setup terlebih dahulu. Setelah melakukan setup pada node Steilger sekarang lakukan testing pada load balancer yang telah dibuat sebelumnya. Yang menjadi pembeda adalah kita harus melakukan testing menggunakan 1 worker, 2 worker, dan 3 worker.

1. Testing menggunakan algoritma Least Connection
```bash
ab -n 1000 -c 100 http://www.harkonen.it31.com/leastconn/
```
a. 3 worker
Dan hasilnya seperti berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_9c.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_9d.png)

b. 2 Worker
Dan hasilnya seperti berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_9a.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_9b.png)

c. 1 worker
Dan hasilnya seperti berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no8_c1LS.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_no8_c1LC.png)

d. Kemudian hasil dari ketiga grafik tersebut adalah:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_grafik_9.png)

### PROBLEM
---
4. Dengan menggunakan algoritma Least-Connection, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 1000 request dengan 10 request/second, kemudian tambahkan grafiknya pada peta. (9)

### SOLUTION
---
4. Sebelum mengerjakan perlu untuk melakukan setup terlebih dahulu. Setelah melakukan setup pada node Steilger sekarang lakukan testing pada load balancer yang telah dibuat sebelumnya. Yang menjadi pembeda adalah kita harus melakukan testing menggunakan 1 worker, 2 worker, dan 3 worker.

1. Testing menggunakan algoritma Least Connection
```bash
ab -n 1000 -c 100 http://www.harkonen.it31.com/leastconn/
```
a. 3 worker
Dan hasilnya seperti berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_9c.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_9d.png)

b. 2 Worker
Dan hasilnya seperti berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_9a.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_9b.png)

c. 1 worker
Dan hasilnya seperti berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/no8_c1LS.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_no8_c1LC.png)

d. Kemudian hasil dari ketiga grafik tersebut adalah:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_grafik_9.png)

### PROBLEM
---
5. Selanjutnya coba tambahkan keamanan dengan konfigurasi autentikasi di LB dengan dengan kombinasi username: “secmart” dan password: “kcksyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/supersecret/ (10)

### SOLUTION
---
5. Sebelum mengerjakan perlu untuk melakukan setup terlebih dahulu. Setelah itu, ubahlah script load balancer pada Stilgar yang sudah dikonfigurasi tersebut dengan:

```bash
mkdir /etc/nginx/supersecret
htpasswd -c /etc/nginx/rahasisakita/htpasswd netics
```
Kemudian diubah untuk konfigurasi di nginx load balancer (Stilgar)

```bash
htpasswd -c /etc/nginx/supersecret/htpasswd netics

echo '
upstream worker {
    server 192.232.1.2;
    server 192.232.1.3;
    server 192.232.1.4;
}

server {
    listen 80;
    server_name harkonen.it31.com www.harkonen.it31.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;   
    }
    
    auth_basic "Restricted Content";
    auth_basic_user_file /etc/nginx/supersecret/htpasswd;
}' > /etc/nginx/sites-available/lb_php
```
Jika sudah memasukkan password dan re-type password. Sekarang bisa dicoba dengan menambahkan command berikut pada setup nginx.

Kemudian kita testing pada client, disini saya hanya menggunakan Dmitri, jalankan command 
```bash
lynx http://www.harkonen.it31.com/
```
Jika sudah memasukkan password dan re-type password. Sekarang bisa dicoba dengan menambahkan command berikut pada setup nginx.

maka akan muncul warning awalnya, namun nantinya akan diminta memasukkan username dan password seperti di bawah ini:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_10_error.png)

Kemudian akan muncul disuruh memasukkan nama dan password yang sudah dibuat yaitu username = secmart dan password = kcksit31. Dan hasilnya seperti ini:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_10_login.png)

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_10_pw.png)

Dan akan muncul tampilan seperti awal:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_10.png)

### PROBLEM
---
6. Lalu buat untuk setiap request yang mengandung /dune akan di proxy passing menuju halaman https://www.dunemovie.com.au/. (11) 
hint: (proxy_pass)

### SOLUTION
---

Sebelum mengerjakan perlu untuk melakukan setup terlebih dahulu. Setelah itu, lakukan beberapa konfigurasi tambahan pada nginx sebagai berikut
```bash
location ~ /its {
    proxy_pass https://www.dunemovie.com.au;
    proxy_set_header Host www.dunemovie.com.au;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```

```bash
echo 'upstream worker {
    server 192.173.3.1;
    server 192.173.3.2;
    server 192.173.3.3;
}

server {
    listen 80;
    server_name granz.channel.a09.com www.granz.channel.a09.com;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    location / {
        proxy_pass http://worker;
    }

    location ~ /its {
        proxy_pass https://www.dunemovie.com.au;
        proxy_set_header Host www.dunemovie.com.au;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}' > /etc/nginx/sites-available/lb_php
```

Maksudnya adalah ketika kita melakukan akses pada endpoint yang mengandung /dunemovie akan diarahkan oleh proxy_pass menuju https://www.dunemovie.com.au. Jadi ketika melakukan testing pada client Dmitri dengan menggunakan perintah berikut:

```bash
lynx www.harkonen.it31.com/dunemovie
```
Dan hasilnya seperti berikut:
![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_11.png)

### PROBLEM
---
7. Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].1.37, [Prefix IP].1.67, [Prefix IP].2.203, dan [Prefix IP].2.207. (12) hint: (fixed in dulu clientnya)

### SOLUTION
---
Untuk problem ini kita tinggal menambahkan script pada load balancer sebelumnya:
```bash
echo '
    upstream worker { # (ip_hash, least_conn, hash $request_uri consistent)
    #hash $request_uri consistent;
    #least_conn;
    #ip_hash;
    server 192.232.1.1:80;
    server 192.232.1.2:80;
    server 192.232.1.3:80;
}

 server {
        listen 80;
        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;

        server_name harkonen.it31.com;

        location / {
                allow 192.232.1.37;
                allow 192.232.1.67;
                allow 192.232.2.203;
                allow 192.232.2.207;
                deny all;
                proxy_pass http://worker;
                auth_basic "Restricted Access";
                auth_basic_user_file /etc/nginx/supersecret/.htpasswd;
        }

        location /dune {
                proxy_pass https://www.dunemovie.com.au/;
                proxy_set_header Host www.dunemovie.com.au;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                auth_basic "Restricted Access";
                auth_basic_user_file /etc/nginx/supersecret/.htpasswd;
        }
} ' > /etc/nginx/sites-available/lb_php
```
Kemudian menambahkan hwadress pada dmitri, dan hasilnya seperti berikut:

![](https://github.com/mrvlvenom/Jarkom-IT31-Modul-3-2024/blob/main/img/hasil_11.png)

### PROBLEM
---
NO 13 - 20
1. Semua data yang diperlukan, diatur pada Chani dan harus dapat diakses oleh Leto, Duncan, dan Jessica. (13)
2. Leto, Duncan, dan Jessica memiliki atreides Channel sesuai dengan quest guide berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer (14)
3. Atreides Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada peta.
- POST /auth/register (15)
- POST /auth/login (16)
- GET /me (17)
4. Untuk memastikan ketiganya bekerja sama secara adil untuk mengatur atreides Channel maka implementasikan Proxy Bind pada Stilgar untuk mengaitkan IP dari Leto, Duncan, dan Jessica. (18)
5. Untuk meningkatkan performa dari Worker, coba implementasikan PHP-FPM pada Leto, Duncan, dan Jessica. Untuk testing kinerja naikkan
- pm.max_children
- pm.start_servers
- pm.min_spare_servers
- pm.max_spare_servers
6. sebanyak tiga percobaan dan lakukan testing sebanyak 100 request dengan 10 request/second kemudian berikan hasil analisisnya pada PDF.(19)
7. Nampaknya hanya menggunakan PHP-FPM tidak cukup untuk meningkatkan performa dari worker maka implementasikan Least-Conn pada Stilgar. Untuk testing kinerja dari worker tersebut dilakukan sebanyak 100 request dengan 10 request/second. (20)

### SOLUTION
---

13. Pada Worker Databse Chani kita jalankan bash berikut untuk init mariadb server:
```bash
echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update
apt-get install isc-dhcp-server -y
```
Ganti bind address pada /etc/mysql/mariadb.conf.d/50-server.cnf menjadi 0.0.0.0, lalu jalankan script mariadb-server.sh
```bash
mysql <<EOF
CREATE USER 'kelompokit31'@'%' IDENTIFIED BY 'passwordit31';
CREATE USER 'kelompokit31'@'localhost' IDENTIFIED BY 'passwordit31';
CREATE DATABASE dbkelompokit31;
GRANT ALL PRIVILEGES ON dbkelompokit31.* TO 'kelompokit31'@'%';
GRANT ALL PRIVILEGES ON dbkelompokit31.* TO 'kelompokit31'@'localhost';
FLUSH PRIVILEGES;
EOF

echo '[client-server]

!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mariadb.conf.d/

[mysqld]
skip-networking=0
skip-bind-address
' > /etc/mysql/my.cnf

service mysql restart
```

14. Pada Worker Laravel Leto, Duncan, dan Jessica jalankan script worker-laravel.sh
```bash
apt-get install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip -y
service php7.3-fpm start

cd /var/www/laravel-praktikum-jarkom && composer update
composer install


cp /var/www/laravel-praktikum-jarkom/.env.example /var/www/laravel-praktikum-jarkom/.env

echo 'APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=192.232.4.1
DB_PORT=3306
DB_DATABASE=dbkelompokit31
DB_USERNAME=kelompokit31
DB_PASSWORD=passwordit31

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
' > /var/www/laravel-praktikum-jarkom/.env

service nginx start
cd /var/www/laravel-praktikum-jarkom
composer update
composer install
service nginx start
php artisan migrate:fresh
php artisan db:seed --class=AiringsTableSeeder
php artisan key:generate
php artisan config:cache
php artisan migrate
php artisan db:seed
php artisan storage:link
php artisan jwt:secret
php artisan config:clear
chown -R www-data.www-data /var/www/laravel-praktikum-jarkom/storage

echo 'server {

    listen 8001;

    root /var/www/laravel-praktikum-jarkom/public;

    index index.php index.html index.htm;
    server_name _;

    location / {
            try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
    }

location ~ /\.ht {
            deny all;
    }

    error_log /var/log/nginx/fff_error.log;
    access_log /var/log/nginx/fff_access.log;
}
' > /etc/nginx/sites-available/fff

ln -s /etc/nginx/sites-available/fff /etc/nginx/sites-enabled/
chown -R www-data.www-data /var/www/laravel-praktikum-jarkom/storage
service php8.0-fpm start
service nginx restart
```
    
15. Untuk melakukan POST request regiester username dan password kami memilih untuk menggunakan file json untuk melakukan request.
```bash
echo '{
  "username": "kelompokit31",
  "password": "passwordit31"
}' > register.json
```
Lalu kita bisa request dengan command ab -n 100 -c 10 -p register.json -T application/json http://192.232.4.2/api/auth/register

16. Untuk melakukan POST request kita bisa menggunakan credentials sebelumnya pada file register.json dan kami akan copy ke file login.json
Lalu kita bisa request dengan command ab -n 100 -c 10 -p login.json -T application/json http://192.232.4.2/api/auth/login

17. Untuk melakukan request GET ke /me kita perlu token login terlebih dahulu, untuk mendapatkan login token kita bisa menggunakan cara berikut :
curl -X POST -H "Content-Type: application/json" -d @login.json http://192.232.4.2:5027/api/auth/login > login_token.txt

Lalu kita akan menggunakan login token tersebut untuk login: token=$(cat login_output.txt | jq -r '.token') && ab -n 100 -c 10 -H "Authorization: Bearer $token" http://192.232.4.2/api/me

18. Kita bisa setup load balancer untuk worker Laravel dengan Script berikut:
```bash
echo 'upstream laravel_worker {
    server 192.232.2.1;
    server 192.232.2.2;
    server 192.232.2.3;
}

server {
    listen 80;
    server_name atreides.it05.com;

    root /var/www/atreides.it05.com;
    index index.html index.htm index.nginx-debian.html;

    location / {
        proxy_pass http://laravel_worker;
    }

    error_log /var/log/nginx/lb_error.log;
    access_log /var/log/nginx/lb_access.log;
}
' > /etc/nginx/sites-available/lb_nginx

service nginx restart
```
19. Pada setiap worker kita bisa set masing masing opsi konfigurasi pada script berikut:
1. Script 1:
```bash
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart
```

2. Script 2:
```bash
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 25
pm.start_servers = 5
pm.min_spare_servers = 3
pm.max_spare_servers = 10' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart
```

3. Script 3:
```bash
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 50
pm.start_servers = 8
pm.min_spare_servers = 5
pm.max_spare_servers = 15' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart
```

20. Untuk setup load balancer least connection kita bisa config nginx dengan script berikut
```bash
echo 'upstream laravel_worker {
    least_conn;
    server 192.232.2.1;
    server 192.232.2.2;
    server 192.232.2.3;
}

server {
    listen 80;
    server_name atreides.it31.com;

    root /var/www/atreides.it31.com;
    index index.html index.htm index.nginx-debian.html;

    location / {
        proxy_pass http://laravel_worker;
    }

    error_log /var/log/nginx/lb_error.log;
    access_log /var/log/nginx/lb_access.log;
}
' > /etc/nginx/sites-available/lb_nginx

service nginx restart
```

