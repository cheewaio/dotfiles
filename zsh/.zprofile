eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/ncurses/bin:$PATH"
export DOCKER_HOST=unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')
export PATH="$(brew --prefix python)/libexec/bin:$PATH"
