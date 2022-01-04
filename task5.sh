# Create INIT script called mongo (or systemd service mongod) that will do:
# Status will check if process is running:
# - NO: message that process is stopped; 
# - YES: Provide PID, Memory consumed by process, on which port is running, network stats for port.
# Start will:
# - check if file /apps/mongo/bin/mongod and folders (/apps/mongodb/ and /logs/mongo/) exist;
# - check if permissions and ownership are set correctly;
#   if all OK – verify if process already running – if running, show the status, 
#   if all not OK – start mongod, send message “$PID is waiting for connections on port <port>” once [initandlisten] appear in logs.
# Stop will get the process ID, kill the process, verify that no mongod processes are running and post proper message.
# Save init script in /etc/init.d/ folder, add mongo to chkconfig, verify that init script (systemd service) is working.

#!/bin/bash
#chkconfig: 2345 20 80
PID=$(pidof mongod)
status(){
echo 'STATUS'
if [ "$PID" ]
then echo "mongod PID is $PID, consumed memory is $(pmap $PID | awk '/total/{print $2}')
listening port is $(netstat -tulpn | awk /$PID/'{print $4}')
traffic statistics for:
$(ip -s link | sed -n 2,6p)"
else echo "stopped"
fi
}
start(){
echo 'CHECK & START'
MONGOD=/home/mongo/apps/mongo/bin/mongod
MONGODB=/home/mongo/apps/mongodb
MONGOLOGS=/home/mongo/logs/mongo
if [ -f "$MONGOD"  ] &&
[ -d "$MONGODB"  ] &&
[ -d "$MONGOLOGS"  ] &&
[ $(stat -c %a $MONGODB) -eq 750 ] &&
[ $(stat -c %a $MONGOLOGS) -eq 740 ] &&
[ "$(stat -c %U $MONGODB)" = mongo ] &&
[ "$(stat -c %U $MONGOLOGS)" = mongo ]; then
if [ "$PID" ]; then
echo "mongod PID is $PID, consumed memory is $(pmap $PID | awk '/total/{print $2}')
listening port is $(netstat -tulpn | awk /$PID/'{print $4}')"
else
$MONGOD> /home/mongo/logs/mongo/logs 2>&1 &
tail -f /home/mongo/logs/mongo/logs | grep -m 1 waiting
fi
fi
}
stop(){
echo 'STOP'
killall -9 mongod> /dev/null 2>&1
if [ ! "$PID" ]
then echo "no mongod is running"
else echo "mongod still alive??"
fi
}
case $1 in
status) status;;
start) start;;
stop) stop;;
restart) stop;start;;
*) echo "Usage: $0 {status|start|stop|restart}"
esac
exit
