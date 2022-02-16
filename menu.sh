#!/bin/bash

green='\e[32m'
blue='\e[34m'
bgblue='\033[44m'
bgred='\033[41m'
white='\033[1;37m'
clear='\e[0m'

# Функции для цветного вывода
ColorGreen(){
    echo -ne $green$1$clear
    echo ""
}
ColorBlue(){
    echo -ne $blue$1$clear
    echo ""
}
BackgroundBlue(){
    echo -ne $bgblue$white$1$clear
    echo ""
}
BackgroundRed(){
    echo -ne $bgred$white$1$clear
    echo ""
}

server_name=$(hostname)
server_ip=$(wget -O - -q icanhazip.com)

open_ports(){
  BackgroundBlue '==================== Cписок открытых портов ss -lupnt ===================='
  echo "" 
  ss -lupnt
  echo ""
  BackgroundBlue '--------------------------------------------------------------------------'
}
load_average(){
  line=$(uptime)
  BackgroundBlue '========== LOAD AVERAGE =========='
  echo ${line#*users,}
  BackgroundBlue '------------------------------------'
}
mem_free(){
 
  BackgroundBlue '==================== Статус оперативной памяти ===================='
  echo ""
  free -h 
  echo ""
  BackgroundBlue '--------------------------------------------------------------------------'
}
kernel_os_version(){
  BackgroundBlue '==================== Информация о версии ядра и ОС ===================='
  echo ""
  echo $(cat /etc/os-release | grep PRETTY_NAME | awk -F"=" '{ print $2 }')
  uname -r
  echo ""
  BackgroundBlue '--------------------------------------------------------------------------'
}
  all_check() {
  open_ports
  load_average
  mem_free
  kernel_os_version
}
menu() {
  echo -ne "
  $(BackgroundBlue ' Сервер ')
  $(BackgroundBlue " $server_ip $server_name ")
  $(ColorGreen '1)') Открытые порты
  $(ColorGreen '2)') Нагрузка на сервер
  $(ColorGreen '3)') ОЗУ 
  $(ColorGreen '4)') Версия ядра
  $(ColorGreen '5)') Check All
  $(ColorGreen '0)') Выход
  $(ColorGreen 'Трулулу')
"
  read a
  case $a in
      1) open_ports ; menu ;;
      2) load_average ; menu ;;
      3) mem_free ; menu ;;
      4) kernel_os_version ; menu ;;
      5) all_check ; menu ;;
    0) exit 0 ;;
    *) BackgroundRed "Неверная опция"; menu;;
  esac
}

menu
