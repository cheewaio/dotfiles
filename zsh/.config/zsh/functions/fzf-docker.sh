function docker_interactive_ps() {
  local command="docker ps $@"

  eval "$command" | \
    fzf --header-lines=1 --height=100% \
        --prompt "> " \
        --header $'Enter (Shell) / F2 (Refresh) ╱ Ctrl-I (Inspect) ╱ Ctrl-K (Kill) ╱ Ctrl-L (Logs) ╱ Ctrl-R (Remove) ╱ Ctrl-X (Restart)\n\n' \
        --bind "ENTER:execute:(docker exec -it {1} bash 2>/dev/null || docker exec -it {1} sh > /dev/tty)" \
        --bind "F2:reload:($command)" \
        --bind "CTRL-I:execute(docker inspect {1} | nvim -R)" \
        --bind "CTRL-K:execute(docker stop {1})" \
        --bind "CTRL-L:execute:(docker logs {1} | nvim +':set ft=log' -R)" \
        --bind "CTRL-R:execute:(docker rm -f {1})" \
        --bind "CTRL-X:execute(docker restart {1})" \
        --preview-window down:follow \
        --preview "docker logs --follow --tail=10000 {1}"
}