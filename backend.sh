log_file=/tmp/expense.log
echo -e "\e[33m Disable Default version of NodeJs\e[0m"
dnf module disable nodejs -y &>>$log_file

echo -e "\e[33m Enable NodeJS18 Version\e[0m"
dnf module enable nodejs:18 -y &>>$log_file

echo -e "\e[33m Install NodeJS\e[0m"
dnf install nodejs -y &>>$log_file

echo -e "\e[33m Configure Backend Service\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file

echo -e "\e[33m Adding Application User\e[0m"
useradd expense &>>$log_file

echo -e "\e[33m Remove existing Application Content\e[0m"
rm -rf /app &>>$log_file

echo -e "\e[33m Create Application Directory\e[0m"
mkdir /app &>>$log_file

echo -e "\e[33m Download Application Content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app &>>$log_file

echo -e "\e[33m Extract the Application Content\e[0m"
unzip /tmp/backend.zip &>>$log_file

echo -e "\e[33m Download Application Dependencies\e[0m"
npm install &>>$log_file

echo -e "\e[33m Reloading SystemD Service\e[0m"
systemctl daemon-reload &>>$log_file

echo -e "\e[33m Start Backend Service\e[0m"
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file

echo -e "\e[33m Install Mysql Client\e[0m"
dnf install mysql -y &>>$log_file

echo -e "\e[33m Load Schema\e[0m"
mysql -h mysql-dev.iamzaheer.online -uroot -p$2 < /app/schema/backend.sql &>>$log_file