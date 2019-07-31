# scp -rp root@*.*.*.*:/etc/orangefs /etc
ketch=$(find /etc/orangefs -name pvfs2.ko)
insmod $ketch
/etc/orangefs/sbin/pvfs2-client
mkdir /mnt/orangefs
grep "Alias " /etc/orangefs/etc/orangefs-server.conf | awk '{ print $3 }' | head -n 1
echo "tcp://local:3334/orangefs /mnt/orangefs pvfs2" >> /etc/pvfs2tab
mount -t pvfs2 tcp://localhost:3334/orangefs /mnt/orangefs
