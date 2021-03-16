#!/bin/bash
#Code by th3_pr3d4t0r
#Colors
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
M='\033[1;35m'
C='\033[1;36m'
W='\033[1;37m'
green='\033[32m'
gray='\033[90m'

arm=$(dpkg --print-architecture)
ver='6.0.35'

echo -e $R"\n"[$B!$R]$G " Actualizando Termux :3\033[00m\n"
sleep 3
pkg update && pkg upgrade
sleep 7

banner() {
clear
echo
echo -e $R"      .:okOOOkdc'           'cdkOOOko:."
echo -e $R"    .xOOOOOOOOOOOOc       cOOOOOOOOOOOOx."
echo -e $R"   :OOOOOOOOOOOOOOOk,   ,kOOOOOOOOOOOOOOO:"
echo -e $R"  'OOOOOOOOOkkkkOOOOO: :OOOOOOOOOOOOOOOOOO'"
echo -e $R"  oOOOOOOOO.    .oOOOOoOOOOl.    ,OOOOOOOOo"
echo -e $R"  dOOOOOOOO.      .cOOOOOc.      ,OOOOOOOOx"
echo -e $R"  lOOOOOOOO.         ;d;         ,OOOOOOOOl"
echo -e $R"  .OOOOOOOO.   .;           ;    ,OOOOOOOO."
echo -e $R"   cOOOOOOO.   .OOc.     'oOO.   ,OOOOOOOc"
echo -e $R"    oOOOOOO.   .OOOO.   :OOOO.   ,OOOOOOo"
echo -e $R"     lOOOOO.   .OOOO.   :OOOO.   ,OOOOOl"
echo -e $R"      ;OOOO'   .OOOO.   :OOOO.   ;OOOO;"
echo -e $R"       .dOOo   .OOOOocccxOOOO.   xOOd."
echo -e $R"         ,kOl  .OOOOOOOOOOOOO. .dOk,"
echo -e $R"           :kk;.OOOOOOOOOOOOO.cOk:"
echo -e $R"             ;kOOOOOOOOOOOOOOOk:"
echo -e $R"               ,xOOOOOOOOOOOx,"
echo -e $R"                 .lOOOOOOOl."
echo -e $R"                    ,dOd,"
echo -e $R"                      ."
echo
}


#Check-OS-MSF
MSF=''
  if [ -d /data/data/com.termux/files/home/metasploit-framework ] ; then
    Check='MSF-instalado'
  elif [ -d /data/data/com.termux/files/opt/metasploit-framework ] ; then
    Check='MSF-instalado'
  fi


  if [ "${Check}" = "MSF-instalado" ]; then
        banner
        echo -e $R"/n"[$B!$R]$G " Vaya lo siento ya tienes Metasploit instalado"
        sleep 1
        echo -e $R"/n"[$B!$R]$G " Abortando..."
	sleep 2
	exit
  fi
#End-Check

architecture() {
if [[ $arm = "arm" ]];then
cp depen/arm/ruby.deb .
elif [[ $arm = "aarch64" ]];then
cp depen/aarch64/ruby.deb .
else
echo -e $R"\n"[$B!$R]$G " Arquitectura no soportada :(\033[00m"
exit 1
fi
}

install() {
banner
echo -e $R"\n"[$B-$R]$G " Ok...\033[00m\n"
pkg install -y neofetch wget curl
apt remove -y ruby
apt install -y libiconv zlib autoconf bison clang coreutils curl findutils git apr apr-util libffi libgmp libpcap postgresql readline libsqlite openssl libtool libxml2 libxslt ncurses pkg-config wget make libgrpc termux-tools ncurses-utils ncurses unzip zip tar termux-elf-cleaner
architecture
chmod +x ruby.deb
apt install -y ./ruby.deb
rm ruby.deb
ln -sf $PREFIX/include/libxml2/libxml $PREFIX/include/
apt-mark unhold ruby
curl -LO https://github.com/rapid7/metasploit-framework/archive/$ver.tar.gz
tar -xf $ver.tar.gz
rm $ver.tar.gz
mv metasploit-framework-$ver metasploit-framework
mkdir $PREFIX/opt > /dev/null 2>&1
mv metasploit-framework $PREFIX/opt > /dev/null 2>&1
cd $HOME
ruby -v
apt-mark hold ruby
cd $PREFIX/opt/metasploit-framework
bundle config build.nokogiri --use-system-libraries
bundle update
wget https://github.com/termux/termux-packages/files/2912002/fix-ruby-bigdecimal.sh.txt
bash fix-ruby-bigdecimal.sh.txt
cd $HOME
mkdir -p $PREFIX/var/lib/postgresql > /dev/null 2>&1
initdb $PREFIX/var/lib/postgresql >/dev/null 2>&1
ln -s $PREFIX/opt/metasploit-framework/msfconsole msfconsole > /dev/null 2>&1
mv msfconsole $PREFIX/bin > /dev/null 2>&1
ln -s $PREFIX/opt/metasploit-framework/msfvenom msfvenom > /dev/null 2>&1
mv msfvenom $PREFIX/bin > /dev/null 2>&1
rm *.txt; rm 1 > /dev/null 2>&1
clear;echo -e $R[$B-$R]$G "INSTALLED SUCCESSFULLY!\n"
msfconsole
}

main
