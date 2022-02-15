#!/bin/bash 

tg="/root/telegram.sh"

NORMAL='\033[0m'      # ${NORMAL} 

WHITE='\033[1;37m'    # ${WHITE}

BGRED='\033[41m'      # ${BGRED}
BGGREEN='\033[42m'    # ${BGGREEN}
BGBLUE='\033[44m'     # ${BGBLUE}


nginxstatus=$(systemctl status nginx | grep -Eo "running|dead|failed") 

if [[ $nginxstatus = 'running' ]]
    then
        echo -en  "$(date) ${WHITE} ${BGGREEN} Веб сервер работает ${NORMAL}\n"
    else 
        echo -en "$(date) ${WHITE} ${BGRED} nginx не работает ${NORMAL}\n"
        $tg "Ngnix не работает" > /dev/null
        systemctl restart nginx
        sleep 3 #
        echo -en "$(date) ${WHITE} ${BGGREEN} Статус Nginx после перезапуска $(systemctl status nginx | grep -Eo "running|dead|failed") ${NORMAL}\n"
        echo $(curl -I 192.168.212.38 | grep OK)
        $tg "$(date) Статус Nginx после перезапуска $(systemctl status nginx | grep -Eo "running|dead|failed")" > /dev/null
fi 
			
phpfpmstatus=`systemctl status php7.2-fpm | grep -Eo "running|dead|failed"`

if [[ $phpfpmstatus = 'running' ]]
    then
        echo -en  "$(date) ${WHITE} ${BGGREEN} php7.2-fpm работает ${NORMAL}\n"
    else 
        echo -en "$(date) ${WHITE} ${BGRED} Статус php7.2-fpm $phpfpmstatus Пробуем перезапустить. ${NORMAL}\n"
        $tg "Php-7.2-fpm не работает" > /dev/null
        systemctl restart php7.2-fpm
        sleep 3
        echo -en "$(date) ${WHITE} ${BGGREEN} Статус php7.2-fpm после перезапуска $(systemctl status php7.2-fpm | grep -Eo "running|dead|failed") ${NORMAL}\n"
        $tg "$(date) Статус php7.2-fpm после перезапуска $(systemctl status php7.2-fpm | grep -Eo "running|dead|failed") " > /dev/null
fi 

