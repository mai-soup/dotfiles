# set variable identifying the chroot you work in (used in the prompt below)
if test -z "$debian_chroot" -a -r /etc/debian_chroot
    set -gx debian_chroot (cat /etc/debian_chroot)
end

# If this is an xterm set the title to user@host:dir
switch $TERM
    case 'xterm*' 'rxvt*'
        function fish_title
            echo $debian_chroot" "(whoami)@(hostname): (pwd)
        end
end

