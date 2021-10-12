#!/bin/bash
  
echo "Installing tftp-server..."
yum -y install tftp tftp-server
echo "service tftp
{
        socket_type             = dgram
        protocol                = udp
        wait                    = yes
        server                  = /usr/sbin/in.tftpd
        server_args             = -s /tftpboot
        disable                 = no
        per_source              = 11
        cps                     = 100 2
        flags                   = IPv4
}
" > /etc/xinetd.d/tftp
chown root:asterisk /tftpboot
chmod 775 /tftpboot
service xinetd restart
echo "TFTP installation completed."
echo " "
echo " "

echo "********** READ THIS CAREFULLY **********"
echo " "
echo "For service outside your private LAN, VPN, and whitelisted IP addresses,"
echo "issue this command to temporarily expose TFTP resources to the Internet:"
echo " "
echo "iptables -I INPUT -p udp --dport 69 -j ACCEPT"
echo " "
echo "When you are finished using TFTP, close this port by restarting IPtables:"
echo " "
echo "iptables-restart"
echo " "
echo "********** READ THIS CAREFULLY **********"
echo " "
