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

alias fahcontrol="(&>/dev/null ~/fahcontrol/FAHControl &)"
alias code=codium
alias config='/usr/bin/git --git-dir=/home/mai/.cfg/ --work-tree=/home/mai'
