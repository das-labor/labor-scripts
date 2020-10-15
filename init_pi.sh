#!/bin/bash

echo '==> install needed packages'
apt install console-data scanbd sane-utils imagemagick git s-nail vim
echo '==> set keyboard to de-latin1'
loadkeys de-latin1
echo '==> comment any not needed scanner types and "net"'
echo '==> default: canon, canon630p, canon_dr, canon_pp, plustek, plustek_pp'
echo '==> editor gets opened in 3 seconds'
sleep 3s
vim /etc/sane.d/dll.conf
echo '==> copying from "sane.d" to "scanbd"'
cp -R /etc/sane.d/* /etc/scanbd
echo '==> creating "/home/pi/prints'
chown pi:pi -R /home/pi/prints
mkdir /home/pi/prints
chmod g+w /home/pi/prints
echo '==> setting perms for user "saned"'
mkdir /var/lib/saned
chown saned:saned /var/lib/saned
adduser saned dialout scanner
cp -R /opt/labor-scripts/superscanner/scanbd/scanbd.conf /etc/scanbd/scanbd.conf
echo '==> in 10 seconds we will test the scanning'
sleep 5s
echo '...4'
sleep 1s
echo '...3'
sleep 1s
echo '...2'
sleep 1s
echo '...1'
sleep 1s
echo '...0'
sudo -u pi bash /opt/labor-scripts/superscanner/scanbd/scan.script
echo '==> sending mail'
sudo -u pi bash /opt/labor-scripts/superscanner/scanbd/email.script
echo '==> creating startup-display service'
cp -R /opt/labor-scripts/superscanner/startup-display.service /etc/systemd/system/
systemctl enable startup-display.service
echo '==> please reboot'
