source /var/lib/alexxa-pro/ipvps.conf
domain=$(cat /etc/xray/domain)
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}           • CREATE TROJAN USER •              ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
tr="$(cat ~/log-install.txt | grep -w "Trojan WS " | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
read -rp "   Input Username : " -e user
if [ -z $user ]; then
echo -e "$COLOR1 ${NC}   [Error] Username cannot be empty "
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1 ${NC}                • HayoSia Store •                 $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)
if [[ ${user_EXISTS} == '1' ]]; then
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}           • CREATE TROJAN USER •              ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC}  Please choose another name."
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1 ${NC}                • HayoSia Store •                 $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
read -n 1 -s -r -p "   Press any key to back on menu"
trojan-menu
fi
done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "   Expired: " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
systemctl restart xray
trojanlink1="trojan://${uuid}@${domain}:${tr}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
trojanlink="trojan://${uuid}@${domain}:${tr}?path=%2Ftrojan-ws&security=tls&host=bug.com&type=ws&sni=bug.com#${user}"
echo "$trojanlink" > /root/akun/tr/trojanws-$user.txt
echo "$trojanlink1" > /root/akun/tr/trojangrpc-$user.txt
clear
echo -e "$COLOR1─────────────────────────────────────────────────${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}           • CREATE TROJAN USER •              ${NC} $COLOR1 $NC"
echo -e "$COLOR1─────────────────────────────────────────────────${NC}"
echo -e "$COLOR1─────────────────────────────────────────────────${NC}"
echo -e "$COLOR1 ${NC} Remarks     : ${user}" 
echo -e "$COLOR1 ${NC} Expired On  : $exp" 
echo -e "$COLOR1 ${NC} Host/IP     : ${domain}" 
echo -e "$COLOR1 ${NC} Port        : ${tr}" 
echo -e "$COLOR1 ${NC} Key         : ${uuid}" 
echo -e "$COLOR1 ${NC} Path        : /trojan-ws"
echo -e "$COLOR1 ${NC} Path WSS    : wss://hayosia/trojan-ws" 
echo -e "$COLOR1 ${NC} ServiceName : trojan-grpc" 
echo -e "$COLOR1─────────────────────────────────────────────────${NC}" 
echo -e "$COLOR1─────────────────────────────────────────────────${NC}"
echo -e "$COLOR1 ${NC} Link WS : "
echo -e "$COLOR1 ${NC} ${trojanlink}" 
echo -e "$COLOR1 ${NC} "
echo -e "$COLOR1 ${NC} Link GRPC : "
echo -e "$COLOR1 ${NC} ${trojanlink1}"
echo -e "$COLOR1─────────────────────────────────────────────────${NC}" 
echo -e "$COLOR1────────────────────── BY ───────────────────────${NC}"
echo -e "$COLOR1 ${NC}                • HayoSia Store •                 $COLOR1 $NC"
echo -e "$COLOR1─────────────────────────────────────────────────${NC}"
echo "" 
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
