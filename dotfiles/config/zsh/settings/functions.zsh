#!/usr/bin/zsh

#     shell helper functions
# most written by Nathaniel Maia
# some pilfered from around the web

# better ls and cd
unalias ls >/dev/null 2>&1
ls()
{
    command ls --color=auto -F "$@"
}

mir()
{
    if hash reflector >/dev/null 2>&1; then
        su -c 'reflector --score 100 --fastest 10 --sort rate \
            --save /etc/pacman.d/mirrorlist --verbose'
    else
        local pg="https://www.archlinux.org/mirrorlist/?country=US&country=CA&use_mirror_status=on"
        su -c "printf 'ranking the mirror list...\n'; curl -s '$pg' |
            sed -e 's/^#Server/Server/' -e '/^#/d' |
            rankmirrors -v -t -n 10 - > /etc/pacman.d/mirrorlist"
    fi
}

ranger()
{
    local dir tmpf
    [[ $RANGER_LEVEL && $RANGER_LEVEL -gt 2 ]] && exit 0
    local rcmd="command ranger"
    [[ $TERM == 'linux' ]] && rcmd="command ranger --cmd='set colorscheme default'"
    tmpf="$(mktemp -t tmp.XXXXXX)"
    eval "$rcmd --choosedir='$tmpf' '${*:-$(pwd)}'"
    [[ -f $tmpf ]] && dir="$(cat "$tmpf")"
    [[ -e $tmpf ]] && rm -f "$tmpf"
    [[ -z $dir || $dir == "$PWD" ]] || builtin cd "${dir}" || return 0
}

mkzip()
{
    zip -r ${PWD##*/}.zip $*
}

arc()
{
    arg="$1"; shift
    case $arg in
        -e|--extract)
            if [[ $1 && -e $1 ]]; then
                case $1 in
                    *.tbz2|*.tar.bz2) tar xvjf "$1" ;;
                    *.tgz|*.tar.gz) tar xvzf "$1" ;;
                    *.tar.xz) tar xpvf "$1" ;;
                    *.tar) tar xvf "$1" ;;
                    *.gz) gunzip "$1" ;;
                    *.zip) unzip "$1" ;;
                    *.bz2) bunzip2 "$1" ;;
                    *.7zip) 7za e "$1" ;;
                    *.rar) unrar x "$1" ;;
                    *) printf "'%s' cannot be extracted" "$1"
                esac
            else
                printf "'%s' is not a valid file" "$1"
            fi ;;
        -n|--new)
            case $1 in
                *.tar.*)
                    name="${1%.*}"
                    ext="${1#*.tar}"; shift
                    tar cvf "$name" "$@"
                    case $ext in
                        .gz) gzip -9r "$name" ;;
                        .bz2) bzip2 -9zv "$name"
                    esac ;;
                *.gz) shift; gzip -9rk "$@" ;;
                *.zip) zip -9r "$@" ;;
                *.7z) 7z a -mx9 "$@" ;;
                *) printf "bad/unsupported extension"
            esac ;;
        *) printf "invalid argument '%s'" "$arg"
    esac
}

