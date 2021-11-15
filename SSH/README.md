# SSH setup with public and private key authentication + overall hardening

This script replaces the /etc/ssh/sshd_config file with a hardened config.

The following values have been changed:
- Protocol 2 = only allows only SSH clients running SSH 2
- PermitRootLogin no = Denies root login attempts 
- MaxAuthTries 5 = Set's the maximum amount of authentication attempts
- MaxSessions 1 = Set's the maximum amount of concurrent connections allowed
- PubkeyAuthentication yes = Enables public Key Authentication
- PasswordAuthentication no = Disables password authentication
- PermitEmptyPasswords no = Disables the use of empty passwords when connecting 
- X11Forwarding no = X11Forwarding technology is enabling GUI applications to be opened remotely
