#!/bin/sh

# Update system
apk update

# Install packages
apk add iproute2 vsftpd

# Configure Network
ip addr add 10.13.37.10/24 dev eth1
ip link set eth1 up

ip route del default via 172.20.20.1 dev eth0
ip route add default via 10.13.37.1 dev eth1 metric 100
ip route add default via 172.20.20.1 dev eth0 metric 200

# Create directory to hold ftp files
mkdir -p /var/run/vsftpd/empty

mkdir -p /home/ftp
chmod -R 755 /home/ftp
chown -R ftp:ftp /home/ftp
chmod a-w /home/ftp

cp /scripts/Stenography/WhatsInHere.jpg /home/ftp/

# Configure vsftpd
cat <<EOF > /etc/vsftpd/vsftpd.conf
# Basic vsftpd configuration
listen=YES
anonymous_enable=YES
anon_root=/home/ftp
no_anon_password=YES
# Additional configuration
local_enable=YES
write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
allow_writeable_chroot=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
seccomp_sandbox=NO
EOF

vsftpd /etc/vsftpd/vsftpd.conf &

echo "FTP server started on qc-admin1 with /home/ftp as the directory."

exit 0