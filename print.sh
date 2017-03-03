#! /bin/sh
# This script calls `lpr` with the necessary arguments.
# You need to understand this script before using it.

PRINTER="CLP-415NW"
pages_orig=`pdfinfo "$1" | grep Pages | tr -s " " | cut -d " " -f 2`
if [ -z ${pages_orig} ]
then
	exit
fi

if [ ${pages_orig} -gt 1 ]
then
	let pages_orig_dec=${pages_orig}-1
else
	pages_orig_dec=${pages_orig}
fi

if [ $pages_orig_dec -gt 1 ]
then
	pages=`printf "1-%d" ${pages_orig_dec}`
else
	pages=1
fi

lpr -d "${PRINTER}" -o page-range=${pages}
echo "$1 pages: ${pages}"