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
@       IN      A       192.232.2.3     ; IP Leto
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
@       IN      A       192.232.1.3     ; IP Vladimir
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