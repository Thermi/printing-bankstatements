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

echo "$1 pages: ${pages}"
# convert PDF to pure post script first and print all pages but the last.
# My bank includes some disclaimers on the last page. That last page has no other content,
# so it can be safely left out without lacking any relevant information.
pdftops -paper A4 -preload "$1" -l "${pages_orig_dec}" - | lpr -P "${PRINTER}" -o page-range=${pages} -
