source common.sh
component=frontend

echo Installing Nginx
dnf install nginx -y &>>$log_file
stat_check

echo Placing Expense config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
stat_check

echo removing old nginx content
rm -rf /usr/share/nginx/html/* &>>$log_file
stat_check

cd /usr/share/nginx/html

Download_and_extract

echo Starting nginx service
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
stat_check
