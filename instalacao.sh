#!/usr/bin/env bash
# install curl
if [ ! -f "/usr/bin/curl" ] && [ ! -f "/bin/curl" ]; then
  apt-get upgrade
  apt-get update
  apt-get install curl
fi
  
# install Samba
if [ ! -f "/etc/samba/smb.conf.old" ]; then
  #apt-get update
	apt-get install samba samba-common-bin
	mkdir /home/share/
	cd /home
	chmod 777 share
	cd /etc
	chmod 777 samba
  cd /etc/samba
	mv smb.conf  smb.conf.old 
	wget  http://sanusb.org/arquivos/smb.zip
	unzip smb.zip
	service samba restart
fi
  
# install Wpi
if [ ! -f "/usr/local/bin/gpio" ]; then
  sudo apt-get install git-core
  git clone git://git.drogon.net/wiringPi
	cd wiringPi
	./build
fi
	
# install sanusb (sanusb.org)
if [ ! -f "/usr/share/sanusb/sanusb" ]; then
  cd /home/share
  wget http://sanusb.org/tools/SanUSBrpi.zip
  unzip SanUSBrpi.zip
  cd SanUSBrpi
  sudo dpkg -i sanusb_raspberry.deb
  chmod +x sanusb
  cp sanusb /usr/share/sanusb
fi
	
# install serial minicom
if [ ! -f "/etc/inittab.out" ]; then
  sudo apt-get install minicom
  wget sanusb.org/tools/serialconfigtest.deb
  dpkg -i serialconfigtest.deb
fi

#echo 18 > /sys/class/gpio/export #wPi 1
#echo out > /sys/class/gpio/gpio18/direction 
gpio mode 1 out

#Start Loop
while :
do
  #echo 1 > /sys/class/gpio/gpio18/value 
  gpio write 1 1 
  echo "hello SanUSB"
  sleep 1

  #echo 0 > /sys/class/gpio/gpio18/value # 
  gpio write 1 0
  echo "hello SanUSB"
  sleep 1
done
