The project is created to make setting up nextcloud as easy as running a single bash script. Some user input is still required but outlined clearly in the steps below. The script installs nginx as the web server and mariadb as the database. It also installs dependency tools such as wget and unzip.

Target OS: Debian 11 (last tested: )


1. Edit the nextcloud version to match the latest (can be found here: https://nextcloud.com/install/#instructions-server) at lines 64 and 67 of the file "install.sh".

2. Make the script executable by running "chmod +x install.sh"

3. Run the script by executing "./install.sh" (without "") in the correct directory containing the "install.sh" and "nextcloud.conf" file.

When you run the script it will initiate the application manager "APT" to install the necessary software (promting you to install shown by "[Y/n]"). Just press ENTER on your keyboard whenever you see this prompt (by default pressing enter selects "Y") to progress the install.

3. MariaDB commands

    CREATE DATABASE nextcloud;

    GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost' IDENTIFIED BY 'mypassword';

    FLUSH PRIVILEGES;

4. Go to your domain name in a browser, register admin account and connect to the mariadb database using your supplied credentials (e.g: username: nextcloud, password: mypassword)
