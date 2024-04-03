echo -e "\e[31m Install Nginx Server\e[0m"
dnf install nginx -y

echo -e "\e[31m Configure frontend Service\e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf

echo -e "\e[31m Remove existing Application content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[31m Downloading the App content\e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

cd /usr/share/nginx/html

echo -e "\e[31m Extracting the App content\e[0m"
unzip /tmp/frontend.zip

echo -e "\e[31m Enable the nginx Service\e[0m"
systemctl enable nginx

echo -e "\e[31m Restart the nginx service\e[0m"
systemctl restart nginx

