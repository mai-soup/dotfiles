function flac-convert
    find . -name "*.flac" -exec bash -c 'ffmpeg -i "{}" -y -acodec libmp3lame -ab 128k "${0/.flac}.mp3"' {} \;
end

function flac-remove
    find . -name "*.flac" -exec rm {} \;
end

function coverart-remove
    find . -name "*.jpg" -exec rm {} \;
    find . -name "*.jpeg" -exec rm {} \;
    find . -name "*.png" -exec rm {} \;
end

function g
    if test (count $argv) -gt 0
        git $argv
    else
        git status
    end
end

function mkv-downsize
    find . -name "*.mkv" -exec bash -c 'ffmpeg -i "{}" -c:a copy -c:s copy -filter:v scale=-1:720 -preset ultrafast -vcodec libx265 -crf 24 -map 0 "${0/.mkv}-upd.mkv"' {} \;
end

function merge_pdfs_original_annotated
    # check if both arguments are provided
    if test (count $argv) -ne 2
        echo "Error: Function requires two arguments: the names of the original and annotated PDFs."
        return 1
    end

    set original_pdf $argv[1]
    set annotated_pdf $argv[2]
    set output_pdf "merged_output.pdf"

    # check if both input files exist
    if not test -f $original_pdf -a -f $annotated_pdf
        echo "Error: One or both of the input files does not exist."
        return 1
    end

    # burst original and annotated PDFs into separate pages
    pdftk $original_pdf burst output original-%d.pdf
    pdftk $annotated_pdf burst output annotated-%d.pdf

    # count the number of pages in the original pdf
    set num_pages (pdfinfo $original_pdf | grep Pages | awk '{print $2}')

    # blend each corresponding page
    for i in (seq 1 $num_pages)
        convert -density 300 original-$i.pdf annotated-$i.pdf -compose Blend -define compose:args=30,70 -composite output-$i.pdf
    end

    # merge output pages
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$output_pdf (ls -v output-*.pdf)

    # clean up intermediate files
    rm original-*.pdf annotated-*.pdf output-*.pdf
end

function drmrf
    docker rm -f (docker ps -a -q); and docker volume rm (docker volume ls -q)
end

alias fahcontrol="nohup ~/fahcontrol/FAHControl >/dev/null 2>&1 &"
alias config="git --git-dir=/home/mai/.cfg/ --work-tree=/home/mai"
alias vite="npm create vite@latest"
alias tailwind="npm install -D tailwindcss postcss autoprefixer && npx tailwindcss init -p"
alias tinify="git diff --diff-filter=ACM --name-only HEAD | grep '.png\|.jpg' | xargs tinypng"
alias focus="/home/mai/go/bin/focus"
alias ghq="/home/mai/go/bin/ghq"
alias vim="nvim"

alias dcd="docker compose down"
alias dcu="docker compose up"

if type -q exa
  alias ls="exa"
  alias la="exa -a"
  alias ll "exa -lg --icons"
  alias lla "ll -a"
end
