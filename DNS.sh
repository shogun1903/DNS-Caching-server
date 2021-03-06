#!/bin/bash
echo "Welcome i#am installing you're DNS Server now"
sudo -i
apt-get install bind9 dnsutils
rm /etc/resolv.conf
echo "name server         10.0.2.15" > /etc/resolv.conf
rm /etc/named.conf
echo '//
// named.conf
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only name server (as a localhost DNS resolver only).
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//
//

options {
        listen-on port 53 { 127.0.0.1; 10.0.2.15; };
//      listen-on-v6 port 53 { ::1; };
        forwarders { 8.8.8.8; 8.8.4.4; };
        directory       "/var/named";
        dump-file       "/var/named/data/cache_dump.db";
        statistics-file "/var/named/data/named_stats.txt";
        memstatistics-file "/var/named/data/named_mem_stats.txt";
        allow-query     { localhost; 10.0.2.0/24; };
        recursion yes;


        dnssec-enable yes;
        dnssec-validation yes;
        dnssec-lookaside auto;


        /* Path to ISC DLV key */
        bindkeys-file "/etc/named.iscdlv.key";


        managed-keys-directory "/var/named/dynamic";
};
logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};
zone "." IN {
        type hint;
        file "named.ca";
};
include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";' > /etc/named.conf
/etc/init.d/bind9 restart
dig google.com
dig google.com
exit
echo "fertig"