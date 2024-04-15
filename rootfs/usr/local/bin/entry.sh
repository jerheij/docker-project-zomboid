#!/bin/bash

# Set default variable if undefined
if [[ -z ${AdminPass} ]]
then
  AdminPass=admin
fi

if [[ -z ${AdminUser} ]]
then
  AdminUser=admin
fi

if [[ -z ${GID} ]]
then
  GID=2000
fi

if [[ -z ${UID} ]]
then
  UID=2000
fi

if [[ -z ${ServerName} ]]
then
  ServerName=PZServer
fi

echo
echo "Admin credentials:"
echo "User: ${AdminUser}"
echo "Password: ${AdminPass}"
echo
echo "GID: ${GID}"
echo "UID: ${UID}"
echo

# Base dirs
mkdir -p /opt/zomboid/data

# Steam update PZ
/usr/bin/steamcmd +runscript /update_zomboid.txt

# Creating group / user with custom UID / GID
groupadd --gid $GID pzuser
useradd --gid $GID --uid $UID -m pzuser

# Final file updates
ln -s /opt/zomboid/config /home/pzuser/Zomboid
chown -R pzuser:pzuser /opt/zomboid

# Creating custom server start binary
#cat >/usr/local/bin/pz.sh <<'EOL'
echo "su pzuser -s /bin/bash -c \"/opt/zomboid/data/start-server.sh -servername ${ServerName} -adminusername ${AdminUser} -adminpassword ${AdminPass}\"" > /usr/local/bin/pz.sh
#EOL

chmod +x /usr/local/bin/pz.sh

exec "$@"
