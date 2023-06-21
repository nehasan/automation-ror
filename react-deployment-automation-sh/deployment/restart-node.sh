ENV=$1

PID=`lsof -i :3001| grep node | awk '{print $2}'`
echo $PID
if [[ "" !=  "$PID" ]]
then
 echo "Killing Node process pid: $PID"
 sudo kill -9 $PID
 echo "Starting Node process..."
 cd /home/deploy/apps/shopoth_ecom_v2_${ENV}
 yarn start -p 3001&> /dev/null &
else
  echo "Node process not found!"
  echo "Starting Node process..."
  cd /home/deploy/apps/shopoth_ecom_v2_${ENV}
  yarn start -p 3001&> /dev/null &
fi
