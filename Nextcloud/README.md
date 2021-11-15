1. Adjust the nextcloud version to match the latest (can be found here: https://nextcloud.com/install/#instructions-server) at lines 43 and 45 of the install script.

1. Run install.sh

2. MariaDB commands

    CREATE DATABASE nextcloud;

    GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost' IDENTIFIED BY 'mypassword';

    FLUSH PRIVILEGES;

6. Go to your domain, register admin account and connect to database
