#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo 'you just needz one...!'
	exit
fi
cd ~/scripts
echo '#!/bin/bash' >> $1
echo '# created by elrey' >> $1
vim $1
chmod +x $1
zsh
