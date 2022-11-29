#!/usr/bin/env sh

######################################################################
# @author      : Sébastien NOBILI (code@pipoprods.org)
# @file        : watermark-pdf
# @created     : 2021-11-14
# @license     : MIT
#
# @description : Add a watermark to a PDF file
######################################################################

watermark_text="$1"
original_pdf=$2

color="rgba(212,212,212,0.4)"
font_size=12

size="$(pdfinfo "$original_pdf" | grep "Page size:" | sed 's/Page size:[ ]*\([0-9]\+\)\([\.][0-9]\+\)\? x \([0-9]\+\)\([\.][0-9]\+\)\? pts.*/\1x\3/')"

# Create work files
transparent_image=$(mktemp --suffix=.png)
watermark_file=$(mktemp --suffix=.pdf)
trap "rm -f $transparent_image $watermark_file;" 0
trap "rm -f $transparent_image $watermark_file; exit 1" 1 2 3 15


# Create a transparent image based on PDF size
convert -size $size xc:transparent $transparent_image

# Fill transparent image with watermark text and write result to watermark PDF file
convert -background transparent -fill "$color" -pointsize $font_size \
        -font DejaVu-Sans label:"$watermark_text" \
        miff:- | \
composite -tile - \
        $transparent_image $watermark_file

# Rotate watemark file if original is landscape
width="$(echo $size | sed 's/x.*//')"
height="$(echo $size | sed 's/.*x//')"
if [ "$width" -gt "$height" ]; then
  pdftk $watermark_file cat 1-endwest output - | sponge $watermark_file
fi

# Add watermark to original PDF
pdftk "$original_pdf" stamp $watermark_file output - | sponge "$original_pdf"

exit 0
