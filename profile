export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
ssh-add ~/.ssh/github > /dev/null 2>&1
