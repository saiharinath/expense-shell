source common.sh
component=backend

echo Install nodeJS repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
 echo -e "\e[31mFAILED\e[0m"
 exit
fi

echo Install nodeJS
dnf install nodejs -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
 echo -e "\e[31mFAILED\e[0m"
 exit
fi

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
 echo -e "\e[31mFAILED\e[0m"
 exit
fi

echo add application user
useradd expense &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
 echo -e "\e[31mFAILED\e[0m"
 exit
fi

echo clean app content
rm -rf /app &>>$log_file
echo $?

mkdir /app
cd /app

Download_and_extract

echo download dependencies
npm install &>>$log_file
echo $?

echo start backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
echo $?

echo Install mysql client
dnf install mysql -y &>>$log_file
echo $?

echo load schema
mysql -h mysql.saiharinath.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?