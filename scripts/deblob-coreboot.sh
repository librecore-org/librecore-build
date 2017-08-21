#!/bin/bash

# For example: "4.6"
COREBOOT_RELEASE=$1

CB="coreboot-${COREBOOT_RELEASE}"
LC="librecore-${COREBOOT_RELEASE}"

rm -fr ${LC}
rm -fr ${CB}
tar Jxf ${CB}.tar.xz
mv ${CB} ${LC}

for b in $(cat blobs-to-remove | grep -Ev "^#" | xargs); do
	if [ -d "${LC}/$b" ]; then
		rm -fr ${LC}/$b
	elif [ -e "${LC}/$b" ]; then
		rm -f ${LC}/$b
	else
		echo "Can't find blob: $b"
	fi
done

for b in $(cat boards-to-remove | grep -Ev "^#" | xargs); do
	if [ -e "${LC}/src/mainboard/$b" ]; then
		rm -fr ${LC}/src/mainboard/$b
	else
		echo "Can't find board: $b"
	fi
done

cp abuild ${LC}/util/abuild/
