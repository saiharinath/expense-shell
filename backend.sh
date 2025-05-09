source common.sh
component=backend

type npm &>>$log_file
  if [$? -ne 0 ]; then
  echo Install nodeJS repos
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  stat_check

  echo Install nodeJS
  dnf install nodejs -y &>>$log_file
  stat_check
fi

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
stat_check

echo add application user
if [ $? -ne 0 ]; then
 useradd expense &>>$log_file
fi
stat_check

echo clean app content
rm -rf /app &>>$log_file
stat_check

mkdir /app
cd /app

Download_and_extract

echo download dependencies
npm install &>>$log_file
stat_check

echo start backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
stat_check

echo Install mysql client
dnf install mysql -y &>>$log_file
stat_check

echo load schema
mysql -h mysql.saiharinath.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
stat_check