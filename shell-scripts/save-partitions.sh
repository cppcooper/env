#!/bin/bash

for p in $(cat /.system/backup/partitions-list); do
	size=$(numfmt --suffix=B --format="%.1f" --to=iec-i $(blockdev --getsize64 /dev/disk/by-partlabel/$p))
	size=$(echo $size | sed -r "s/(\..)/\1 /g")
	echo "backing up $p ($size)"
	mkdir -p /nas/backup/partitions
	dd if=/dev/disk/by-partlabel/$p of=/nas/backup/partitions/$p status=progress
	echo
done
