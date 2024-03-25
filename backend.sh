echo -e "\e[33m Disable Default version of NodeJs\e[0m"
dnf module disable nodejs -y &>/tmp/expense.log

echo -e "\e[33m Enable NodeJS18 Version\e[0m"
dnf module enable nodejs:18 -y &>/tmp/expense.log

echo -e "\e[33m Install NodeJS\e[0m"
dnf install nodejs -y &>/tmp/expense.log

echo -e "\e[33m Configure Backend Service\e[0m"
cp backend.service /etc/systemd/system/backend.service &>/tmp/expense.log

echo -e "\e[33m Adding Application User\e[0m"
useradd expense &>/tmp/expense.log

echo -e "\e[33m Remove existing Application Content\e[0m"
rm -rf /app &>/tmp/expense.log

echo -e "\e[33m Create Application Directory\e[0m"
mkdir /app &>/tmp/expense.log

echo -e "\e[33m Download Application Content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>/tmp/expense.log
cd /app &>/tmp/expense.log

echo -e "\e[33m Extract the Application Content\e[0m"
unzip /tmp/backend.zip &>/tmp/expense.log

echo -e "\e[33m Download Application Dependencies\e[0m"
npm install &>/tmp/expense.log

echo -e "\e[33m Reloading SystemD Service\e[0m"
systemctl daemon-reload &>/tmp/expense.log

echo -e "\e[33m Start Backend Service\e[0m"
systemctl enable backend &>/tmp/expense.log
systemctl restart backend &>/tmp/expense.log

echo -e "\e[33m Install Mysql Client\e[0m"
dnf install mysql -y &>/tmp/expense.log

echo -e "\e[33m Load Schema\e[0m"
mysql -h mysql-dev.iamzaheer.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>/tmp/expense.log