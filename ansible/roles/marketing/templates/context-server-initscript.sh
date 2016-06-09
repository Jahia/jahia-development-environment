#!/bin/bash
#
# chkconfig: 345 99 28
# description: Starts/Stops Context Server
#
#

#Location of JAVA_HOME (bin files)
export CONTEXT_SERVER_HOME={{mf_name}}

#CONTEXT_SERVER_USAGE is the message if this script is called without any options
CONTEXT_SERVER_USAGE="Usage: $0 {\e[00;32mstart\e[00m|\e[00;31mstop\e[00m|\e[00;32mstatus\e[00m|\e[00;31mrestart\e[00m}"

#SHUTDOWN_WAIT is wait time in seconds for java proccess to stop
SHUTDOWN_WAIT=20

context_server_pid() {
        echo `ps -fe | grep $CONTEXT_SERVER_HOME | grep -v grep | tr -s " "|cut -d" " -f2`
}

start() {
  pid=$(context_server_pid)
  if [ -n "$pid" ]
  then
    echo -e "\e[00;Context Server is already running (pid: $pid)\e[00m"
  else
    # Start Context Server
    echo -e "\e[00;32mStarting Context Server\e[00m"
    #ulimit -n 100000
    #umask 007
    #/bin/su -p -s /bin/sh Context Server
        sh $CONTEXT_SERVER_HOME/bin/start
        status
  fi
  return 0
}

status(){
          pid=$(context_server_pid)
          sh $CONTEXT_SERVER_HOME/bin/status
#          if [ -n "$pid" ]; then echo -e "\e[00;32mContext Server is running with pid: $pid\e[00m"
#          else echo -e "\e[00;31mContext Server is not running\e[00m"
#          fi
}

stop() {
  pid=$(context_server_pid)
  if [ -n "$pid" ]
  then
    echo -e "\e[00;31mStoping Context Server\e[00m"
    #/bin/su -p -s /bin/sh Context Server
        sh $CATALINA_HOME/bin/stop

    let kwait=$SHUTDOWN_WAIT
    count=0;
    until [ `ps -p $pid | grep -c $pid` = "0" ] || [ $count -gt $kwait ]
    do
      sleep 1
      let count=$count+1;
    done

    if [ $count -gt $kwait ]; then
      echo -n -e "\n\e[00;31mkilling processes which didn't stop after $SHUTDOWN_WAIT seconds\e[00m"
      kill -9 $pid
    fi
  else
    echo -e "\e[00;31mContext Server is not running\e[00m"
  fi

  return 0
}

case $1 in

        start)
          start
        ;;

        stop)
          stop
        ;;

        restart)
          stop
          start
        ;;

        status)
          status

        ;;

        *)
          echo -e $CONTEXT_SERVER_USAGE
        ;;
esac
exit 0