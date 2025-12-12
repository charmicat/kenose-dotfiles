
# password generator
genpasswd() {
    local l=$1
        [ "$l" == "" ] && l=20
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}


# cheatsheet reader
cheatsheet() {
    [ "$1" == "" ] && echo "Need to choose one of: $(ls "$HOME"/Documents/cheatsheets/)" && return 1
    xmessage -nearmouse -center -buttons close:0 -default close -file "$HOME"/Documents/cheatsheets/"$1"
}

