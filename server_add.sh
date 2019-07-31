# scp root@*.*.*.*:/etc/orangefs /etc
/etc/orangefs/sbin/pvfs2-server -f /etc/orangefs/etc/orangefs-server.conf -a localhost
/etc/orangefs/sbin/pvfs2-server /etc/orangefs/etc/orangefs-server.conf -a localhost
