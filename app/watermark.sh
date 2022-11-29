#!/bin/bash

source "$(dirname $0)/cgibashopts"

echo "Content-type: application/pdf"
echo "Content-disposition: inline; filename=\"${FORM_file}\""
echo ""

watermark-pdf.sh "$FORM_text" $CGIBASHOPTS_DIR/file 2>/dev/null

cat $CGIBASHOPTS_DIR/file

cgibashopts_clean
