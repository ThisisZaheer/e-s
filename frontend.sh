source common.sh

Head "Install Nginx Server"
dnf install nginx -y &>>$log_file
echo $?

Head "Configure frontend Service"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?

Head "Remove existing Application content"
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?

Head "Downloading the App content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
echo $?

cd /usr/share/nginx/html

Head "Extracting the App content"
unzip /tmp/frontend.zip &>>$log_file
echo $?

Head "Enable the nginx Service"
systemctl enable nginx &>>$log_file
echo $?

Head "Restart the nginx service"
systemctl restart nginx &>>$log_file
echo $?

