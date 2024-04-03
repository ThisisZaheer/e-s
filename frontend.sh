log_file=/tmp/expense.log

Head() {
  
  echo -e "\e[31m$1\e[0m"
}
Head "Install Nginx Server"
dnf install nginx -y &>>$log_file

Head "Configure frontend Service"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file

Head "Remove existing Application content"
rm -rf /usr/share/nginx/html/* &>>$log_file

Head "Downloading the App content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file

cd /usr/share/nginx/html

Head "Extracting the App content"
unzip /tmp/frontend.zip &>>$log_file

Head "Enable the nginx Service"
systemctl enable nginx &>>$log_file

Head "Restart the nginx service"
systemctl restart nginx &>>$log_file

