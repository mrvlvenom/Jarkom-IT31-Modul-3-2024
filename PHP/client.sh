apt update
apt install lynx -y
apt install htop -y
apt install apache2-utils -y

# test no 7 dan 8
# aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000 request dan 100 request/second. (7)
ab -n 5000 -c 150 http://www.harkonen.it31.com/ 
