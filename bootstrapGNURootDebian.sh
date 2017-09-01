#!/bin/bash

# Use to initialize GNURoot Debian to something useful. 
# GNURoot Debian Google Play link: https://play.google.com/store/apps/details?id=com.gnuroot.debian
# Once this script is run, you should be able to run ssh into the Android device and run TMUX
# WARNING, if the GNURoot Debian isn't in the foreground, Android might close the app.

# set root password to super 100% unhackable password!
echo -e "1234554321\n1234554321" | passwd

# borrowed from the Raspberry Pi script that prints this
# '"'"' is an escaped `'` (ie 'hello' + " ' " + 'world')
CHECK_PASSWORD_SCRIPT='
check_hash () {
	if ! id -u root > /dev/null 2>&1 ; then return 0 ; fi
	if grep -q "^PasswordAuthentication\s*no" /etc/ssh/sshd_config ; then return 0 ; fi
	test -x /usr/bin/mkpasswd || return 0
	SHADOW="$(sudo -n grep -E '"'"'^root:'"'"' /etc/shadow 2>/dev/null)"
	test -n "${SHADOW}" || return 0
	if echo $SHADOW | grep -q "root:!" ; then return 0 ; fi
	SALT=$(echo "${SHADOW}" | sed -n '"'"'s/root:\$6\$//;s/\$.*//p'"'"')
	HASH=$(mkpasswd -msha-512 1234554321 "$SALT")
	test -n "${HASH}" || return 0

	if echo "${SHADOW}" | grep -q "${HASH}"; then
		echo
		echo "SSH is enabled and the default password for root has not been changed."
		echo "This is a security risk - please login as root and type passwd to set a new password."
		echo
	fi
}

if /usr/sbin/service ssh status | grep -q running; then
	check_hash
fi
unset check_hash
'

# checks the password automatically if it hasn't been changed
echo "$CHECK_PASSWORD_SCRIPT" > /etc/profile.d/sshpasswd.sh

# whois is required for mkpasswd
apt update && apt install whois apt-utils dialog -y

#ssh server
apt install openssh-server -y

# changes ssh port to 2022 as Android uses every port below 2000
# or adds Port line if it does not exist
sed -i -e 's/.*Port.*/Port 2022/' -e 't' -e '$ a\Port 2022' /etc/ssh/sshd_config

# changes ssh port to 2022 as Android uses every port below 2000
# or adds Port line if it does not exist
sed -i -e 's/.*UsePrivilegeSeparation.*/UsePrivilegeSeparation no/' -e ' t' -e '$ a\UsePrivilegeSeparation no' /etc/ssh/sshd_config

# changes ssh port to 2022 as Android uses every port below 2000
# or adds Port line if it does not exist
sed -i -e 's/.*PermitRootLogin.*/PermitRootLogin yes/' -e 't' -e '$ a\PermitRootLogin yes' /etc/ssh/sshd_config

# UsePAM no, for some reason PAM doesn't work on GNURoot Debian
sed -i -e 's/.*UsePAM.*/UsePAM no/' -e 't' -e '$ a\UsePAM no' /etc/ssh/sshd_config

# GNURoot Debian can't use systemd, so ssh doesn't automatically startup on boot
# However, making it startup on login is good enough, since the app
# automatically logins on startup.
LAUNCH_SSH_SERVICE='
service ssh start
'
echo "$LAUNCH_SSH_SERVICE" > /etc/profile.d/launchSSHService.sh

# for some reason default bash command doesn't source /etc/profile so force it to.
# this means the moment GNURoot Debian is openned, the ssh service is started
echo "source /etc/profile" > /home/.bashrc

service ssh restart
echo "Should have started ssh-server at $(hostname -I) with port 2022."
echo "Login with username root, and password 1234554321"

# install tmux, start a session, then upgrade in the tmux session
apt install tmux -y
tmux new-session -d -s my_session 'apt-get update && apt-get install git sudo apt -y && apt-get upgrade -y && apt autoremove -y'
