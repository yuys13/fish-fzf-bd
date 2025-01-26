function __bd_list
    set -l dir (pwd)
    for i in (seq 1 20)
        set dir (dirname $dir)
        echo $dir
        if test $dir = /
            break
        end
    end
end

function bd --description 'Quickly go back to a parent directory up in $PWD'
    set --local selected_repo (__bd_list | env FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" fzf)
    if test -z $selected_repo
        commandline -f repaint
        return
    end

    commandline --replace " cd $selected_repo"
    commandline -f repaint
    commandline -f execute
end
