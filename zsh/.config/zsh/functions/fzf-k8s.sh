export KUBE_EDITOR="nvim"

function kubectl_interactive_get() {
  if [[ $# -eq 0 ]]; then
    local resource_type=$(kubectl api-resources --no-headers | awk '{print $1}' | fzf --header='NAME')
    local opt=""
  else
    local resource_type=$1
    shift
    local opt="$@"
  fi

  if [[ "$resource_type" == "pods" || "$resource_type" == "pod" || "$resource_type" == "po" ]]; then
      local command="kubectl get ${resource_type} ${opt}"
      eval "$command" | \
        fzf --header-lines=1 --height=90% \
            --prompt "> " \
            --header $'Enter (Preview Logs) ╱ Ctrl-B (Bash) / Ctrl-D (Describe) ╱ Ctrl-E (Edit) ╱ Ctrl-K (Kill) ╱ Ctrl-L (Full Logs) / Ctrl-N (Namespace) ╱ Ctrl-R (Refresh) / Ctrl-Y (YAML)\n\n' \
            --bind "ESC:change-preview-window(hidden)" \
            --bind "Enter:preview(kubectl logs -f {1})" \
            --bind "CTRL-B:execute:(kubectl exec -it {1} -- bash 2>/dev/null || kubectl exec -it {1} -- sh > /dev/tty)" \
            --bind "CTRL-D:execute(kubectl describe ${resource_type} {1} | nvim -R)" \
            --bind "CTRL-E:execute:(kubectl edit ${resource_type} {1})" \
            --bind "CTRL-K:execute:(kubectl delete ${resource_type} {1})" \
            --bind "CTRL-L:execute:(kubectl logs {1} | nvim +':set ft=log' -R)" \
            --bind "CTRL-N:execute-silent(kubectl get ns -o custom-columns=:metadata.name | grep -v '^$' | fzf --tmux | xargs -r kubectl config set-context --current --namespace > /dev/null\)" \
            --bind "CTRL-R:reload:($command)" \
            --bind "CTRL-Y:execute:(kubectl get ${resource_type} {1} -o yaml | nvim +':set ft=yaml' -R)" \
            --preview-window down:follow:wrap:80% 
  else
      local command="kubectl get ${resource_type} ${opt}"
      eval "$command" | \
        fzf --header-lines=1 --height=90% \
            --prompt "> " \
            --header $'Ctrl-D (Describe) ╱ Ctrl-E (Edit) ╱ Ctrl-K (Kill) / Ctrl-N (Namespace) ╱ Ctrl-R (Refresh) / Ctrl-Y (YAML)\n\n' \
            --bind "ESC:change-preview-window(hidden)" \
            --bind "Enter:preview(kubectl logs -f {1})" \
            --bind "CTRL-D:execute(kubectl describe ${resource_type} {1} | nvim -R)" \
            --bind "CTRL-K:execute:(kubectl delete ${resource_type} {1})" \
            --bind "CTRL-N:execute-silent(kubectl get ns -o custom-columns=:metadata.name | grep -v '^$' | fzf --tmux | xargs -r kubectl config set-context --current --namespace > /dev/null\)" \
            --bind "CTRL-R:reload:($command)" \
            --bind "CTRL-Y:execute:(kubectl get ${resource_type} {1} -o yaml | nvim +':set ft=yaml' -R)" \
            --preview-window down:follow:wrap:80% 
  fi
}

function kubectl_switch_context() {
  kubectl config get-contexts -o name | fzf --header 'CONTEXT' | xargs -r kubectl config use-context
}

function kubectl_switch_namespace() {
  local opt=$@
  if [[ -n "$opt" ]]; then
    # if an option is provided, use it as the command to execute
    kubectl config set-context --current --namespace "$opt"
  else
    kubectl get ns -o custom-columns=:metadata.name | grep -v '^$' | fzf --header 'NAMESPACE' | xargs -r kubectl config set-context --current --namespace
  fi
}

function kubectl_exec() {
  local opt=$@

  # select pod
  local pod=$(kubectl get pods --no-headers | awk '{print $1}' | fzf --header='Pod')
  [[ -z "$pod" ]] && return

  # select container (if more than one)
  local container=$(kubectl get pod "$pod" -o jsonpath='{.spec.containers[*].name}' | tr ' ' '\n' | fzf --header='CONTAINER')
  [[ -z "$container" ]] && return

  if [[ -n "$opt" ]]; then
    # if an option is provided, use it as the command to execute
    kubectl exec -it "$pod" -c "$container" -- $opt
  else
    # try /bin/bash, fallback to /bin/sh
    kubectl exec -it "$pod" -c "$container" -- /bin/bash 2>/dev/null ||
    kubectl exec -it "$pod" -c "$container" -- /bin/sh
  fi
}

function kubectl_logs() {
  local opt=$*

  # select pod
  local pod=$(kubectl get pods --no-headers | awk '{print $1}' | fzf --header='POD')
  [[ -z "$pod" ]] && return

  # select container (if more than one)
  local container
  container=$(kubectl get pod "$pod" -o jsonpath='{.spec.containers[*].name}' | tr ' ' '\n' | fzf --header='CONTAINER')
  [[ -z "$container" ]] && return

  if [[ -n "$opt" ]]; then
    kubectl logs $opt "$pod" -c "$container"
  else
    kubectl logs "$pod" -c "$container" | bat --language=log --paging=always
  fi
}

function kubectl_delete() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: kdel <resource_type>"
    return 1
  fi

  local resource_type=$1
  local resource=$(_kselect_ "$resource_type")
  [[ -z "$resource" ]] && return
  
  kubectl delete $resource_type $resource
}

function kubectl_describe() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: kdesc <resource_type>"
    return 1
  fi

  local resource_type=$1
  local resource=$(_kselect_ "$resource_type")
  [[ -z "$resource" ]] && return
  
  kubectl describe $resource_type $resource
}

function kubectl_output_yaml() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: kyaml <resource_type>"
    return 1
  fi

  local resource_type=$1
  local resource=$(_kselect_ "$resource_type")
  [[ -z "$resource" ]] && return
  
  kubectl get $resource_type $resource -o yaml | bat --language=yaml --paging=always
}

function kubectl_edit() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: kedit <resource_type>"
    return 1
  fi

  local resource_type=$1
  local resource=$(_kselect_ "$resource_type")
  [[ -z "$resource" ]] && return
  
  kubectl edit $resource_type $resource
}

function kubectl_pod_image() {
  local resource_type=$1
  local resource=$(_kselect_ "pod")
  [[ -z "$resource" ]] && return
 
  kubectl get pod $resource -o "custom-columns=CONTAINER:.spec.containers[*].name,IMAGE:.spec.containers[*].image"
}

function kubectl_top_pods() {
  local opt=$@

  # select namespace
  local namespace=$(kubectl get ns -o custom-columns=:metadata.name | grep -v '^$' | fzf --header='NAMESPACE')
  [[ -z "$namespace" ]] && return

  # select pod
  local pod=$(kubectl get pods -n "$namespace" --no-headers | awk '{print $1}' | fzf --header='POD')
  [[ -z "$pod" ]] && return

  if [[ -n "$opt" ]]; then
    kubectl top pod "$pod" -n "$namespace" $opt
  else
    kubectl top pod "$pod" -n "$namespace"
  fi
}

function _kselect_() {
  local resource_type=$1

  # select resource
  local header=$(echo "$resource_type"  | sed 's/s$//i' | tr '[:lower:]' '[:upper:]')
  local resource=$(kubectl get $resource_type --no-headers | awk '{print $1}' | fzf --header="$header")
  [[ -z "$resource" ]] && return

  echo $resource
}
