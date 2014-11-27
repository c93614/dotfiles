if [ "$SSH_TTY" -a "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "/tmp/ssh-agent-$USER.sock" ]; then
    ln -sfn $SSH_AUTH_SOCK /tmp/ssh-agent-$USER.sock
    export SSH_AUTH_SOCK=/tmp/ssh-agent-$USER.sock
fi

# 同时增加了一个函数，方便重建软连接，有些情况下用得着。
update_ssh_agent() {
    for sock in /tmp/ssh-*/agent*
    do
        if [ -S $sock -a $(stat -c '%U' $sock) = $USER ]; then
            ln -sfn $sock /tmp/ssh-agent-$USER.sock
        fi
    done
}

