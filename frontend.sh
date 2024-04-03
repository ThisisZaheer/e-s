echo Install Nginx Server
dnf install nginx -y

echo Configure frontend Service
cp expense.conf /etc/nginx/default.d/expense.conf

echo Remove existing Application content
rm -rf /usr/share/nginx/html/*

echo Downloading the App content
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

cd /usr/share/nginx/html

echo Extracting the App content
unzip /tmp/frontend.zip

echo Enable & Start Nginx Service
systemctl enable nginx
systemctl restart nginx

