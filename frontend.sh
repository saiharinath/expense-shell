dnf install nginx -y

cp expense.conf /etc/nginx/default.d/expense.conf

systemctl enable nginx
systemctl start nginx
rm -rf /usr/share/nginx/html/*

curl -s-o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

# shellcheck disable=SC2164
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

systemctl restart nginx

