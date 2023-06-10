flac-convert () {
  find -name "*.flac" -exec bash -c 'ffmpeg -i "{}" -y -acodec libmp3lame -ab 128k "${0/.flac}.mp3"' {} \;
}

flac-remove () {
  find -name "*.flac" -exec rm {} \;
}

coverart-remove () {
  find -name "*.jpg" -exec rm {} \;
  find -name "*.jpeg" -exec rm {} \;
  find -name "*.png" -exec rm {} \;
}

g () {
  if [ "$#" -ne 0 ]; then
    git "$@";
  else
    git status;
  fi
}

mkv-downsize () {
  find -name "*.mkv" -exec bash -c 'ffmpeg -i "{}" -c:a copy -c:s copy -filter:v scale=-1:720 -preset ultrafast -vcodec libx265 -crf 24 -map 0 "${0/.mkv}-upd.mkv"' {} \;
}

merge_pdfs_original_annotated () {
    # check if both arguments are provided
    if [ $# -ne 2 ]; then
        echo "Error: Function requires two arguments: the names of the original and annotated PDFs."
        return 1
    fi

    original_pdf=$1
    annotated_pdf=$2
    output_pdf="merged_output.pdf"

    # check if both input files exist
    if [ ! -f $original_pdf ] || [ ! -f $annotated_pdf ]; then
        echo "Error: One or both of the input files does not exist."
        return 1
    fi

    # burst original and annotated PDFs into separate pages
    pdftk $original_pdf burst output original-%d.pdf
    pdftk $annotated_pdf burst output annotated-%d.pdf

    # count the number of pages in the original pdf
    num_pages=$(pdfinfo $original_pdf | grep Pages | awk '{print $2}')

    # blend each corresponding page
    for i in $(seq 1 $num_pages)
    do
      convert -density 300 original-$i.pdf annotated-$i.pdf -compose Blend -define compose:args=30,70 -composite output-$i.pdf
    done

    # merge output pages
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$output_pdf $(ls -v output-*.pdf)

    # clean up intermediate files
    rm original-*.pdf annotated-*.pdf output-*.pdf
}


alias fahcontrol="(&>/dev/null ~/fahcontrol/FAHControl &)"
alias code=codium
alias config='/usr/bin/git --git-dir=/home/mai/.cfg/ --work-tree=/home/mai'
alias vite="npm create vite@latest"
alias tailwind="npm install -D tailwindcss postcss autoprefixer && npx tailwindcss init -p"
alias tinify="git diff --diff-filter=ACM --name-only HEAD | grep ".png\|.jpg" | xargs tinypng"
