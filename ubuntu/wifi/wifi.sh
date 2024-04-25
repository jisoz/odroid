# dungle 1 : wlx5c628b4c2c4e dana
# dungle 2 : wlx5c628b4c0b90 mohamad
# dungle 3 : wlx5c628b4be560
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install wireless-tools wpasupplicant make
sudo apt-get -y install bc build-essential
sudo apt-get -y install linux-headers-$(uname -r)
iwconfig # to get wifi adapter informations

# example
wlx5c628b4c0b90  unassociated  ESSID:""  Nickname:"<WIFI@REALTEK>"
          Mode:Auto  Frequency=2.412 GHz  Access Point: Not-Associated   
          Sensitivity:0/0  
          Retry:off   RTS thr:off   Fragment thr:off
          Power Management:off
          Link Quality=0/100  Signal level=0 dBm  Noise level=0 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

# git clone https://github.com/ivanovborislav/rtl8188eu.git
# cd rtl8188eu
# sudo apt-get install bc build-essential
# sudo apt-get install linux-headers-$(uname -r)
# make ARCH=arm64 CROSS_COMPILE= -C /lib/modules/4.19.219-odroid-arm64/build M=/home/odroid/wifi/rtl8188eu-2  modules

mkdir /home/odroid/wifi/
scp -r mbhshehade@192.168.0.192:/home/mbhshehade/documentations/odroid/materials/wifi-drivers/rtl8188eu-1 /home/odroid/wifi/
scp -r mbhshehade@192.168.0.192:/home/mbhshehade/documentations/odroid/materials/wifi-drivers/rtl8188eu-2 /home/odroid/wifi/

cd wifi/rtl8188eu-1
make 
make install
make uninstall
cd ../rtl8188eu-2
make install

sudo reboot
sudo ifconfig wlx5c628b4be560 up
sudo iwlist wlx5c628b4be560 scan

echo "
network:
 version: 2 
 wifis:
   wlx5c628b4be560:
     access-points:
       bm-wrt:
         password: bm808926
     dhcp4: true
" > /etc/netplan/00-installer-config.yaml

echo "
ctrl_interface=/run/wpa_supplicant
update_config=1
network={
    ssid="bm-wrt"
    psk="bm808926"
}
" > /etc/systemd/system/wpa_supplicant.conf

sudo wpa_supplicant -B -i wlx5c628b4be560 -c /etc/systemd/system/wpa_supplicant.conf
sudo netplan apply 


192.168.1.10


vi /etc/modprobe.d/8188eu.conf


wlx5c628b4c0f15