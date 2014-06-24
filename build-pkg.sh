#!/bin/sh

usage ()
{
	echo "Usage: $0 <manifest_template> <files_directory>"
	exit
}

if [ "$#" -ne 2 ]
then
	usage
fi

manifest_template=$1
files_dir=$2
DIR_SIZE=$(find ${files_dir} -type f -exec stat -f %z {} + | awk 'BEGIN {s=0} {s+=$1} END {print s}')
export DIR_SIZE
{
	. ${manifest_template}
	# Add files in
	echo "files:"
	find ${files_dir} -type f -exec sha256 -r {} + |
		awk '{print "    /" $2 ": " $1}'
	# Add symlinks in
	find ${files_dir} -type l |
		awk "{print \"    /\" \$1 \": '-'\"}"

	# Add files_directories in
	echo "files_directories:"
	find ${files_dir} -type d -mindepth 1 |
		awk '{print "    /" $1 ": y"}'

} | sed -e "s:${files_dir}::" > +MANIFEST

# Create the package
pkg create -r ${files_dir} -m . -o .
