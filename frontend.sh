source common.sh
echo Installing Nginx
dnf install nginx -y >>$log_file

echo Placing Expense config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf >>$log_file

echo removing old nginx content
rm -rf /usr/share/nginx/html/* >>$log_file

echo Download frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>$log_file

cd /usr/share/nginx/html

echo Extracting frontend code
unzip /tmp/frontend.zip >>$log_file

echo Starting nginx service
systemctl enable nginx >>$log_file
systemctl restart nginx >>$log_file

