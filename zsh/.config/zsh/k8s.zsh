export KUBE_EDITOR="nvim"

function kctx() {
  kubectl config get-contexts -o name | fzf --prompt="Context> "  | xargs -r kubectl config use-context
}

function kns() {
  local opt=$*
  if [[ -n "$opt" ]]; then
    # If an option is provided, use it as the namespace
    kubectl config set-context --current --namespace "$opt"
  else
    kubectl get ns -o custom-columns=:metadata.name | grep -v '^$' | fzf --prompt="Namespace> " | xargs -r kubectl config set-context --current --namespace
  fi
}

function kexec() {
  local opt=$*

  # select pod
  local pod
  pod=$(kubectl get pods --no-headers | awk '{print $1}' | fzf --prompt="Pod> ")
  [[ -z "$pod" ]] && return

  # select container (if more than one)
  local container
  container=$(kubectl get pod "$pod" -o jsonpath='{.spec.containers[*].name}' | tr ' ' '\n' | fzf --prompt="Container> ")
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

function klogs() {
  local opt=$*

  # select pod
  local pod
  pod=$(kubectl get pods --no-headers | awk '{print $1}' | fzf --prompt="Pod> ")
  [[ -z "$pod" ]] && return

  # select container (if more than one)
  local container
  container=$(kubectl get pod "$pod" -o jsonpath='{.spec.containers[*].name}' | tr ' ' '\n' | fzf --prompt="Container> ")
  [[ -z "$container" ]] && return

  if [[ -n "$opt" ]]; then
    kubectl logs $opt "$pod" -c "$container"
  else
    kubectl logs "$pod" -c "$container" | bat --language=log --paging=always
  fi
}

function kdel() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: kdel <resource_type>"
    return 1
  fi

  local resource_type=$1
  local resource=$(kselect "$resource_type")
  [[ -z "$resource" ]] && return
  
  kubectl delete $resource_type $resource
}

function kdesc() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: kdesc <resource_type>"
    return 1
  fi

  local resource_type=$1
  local resource=$(kselect "$resource_type")
  [[ -z "$resource" ]] && return
  
  kubectl describe $resource_type $resource
}

function kyaml() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: kyaml <resource_type>"
    return 1
  fi

  local resource_type=$1
  local resource=$(kselect "$resource_type")
  [[ -z "$resource" ]] && return
  
  kubectl get $resource_type $resource -o yaml | bat --language=yaml --paging=always
}

function kedit() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: kedit <resource_type>"
    return 1
  fi

  local resource_type=$1
  local resource=$(kselect "$resource_type")
  [[ -z "$resource" ]] && return
  
  kubectl edit $resource_type $resource
}

function kimage() {
  local resource_type=$1
  local resource=$(kselect "pod")
  [[ -z "$resource" ]] && return
 
  kubectl get pod $resource -o "custom-columns=CONTAINER:.spec.containers[*].name,IMAGE:.spec.containers[*].image"
}

function kselect() {
  local resource_type=$1

  # select resource
  local resource
  resource=$(kubectl get $resource_type --no-headers | awk '{print $1}' | fzf --prompt="${resource_type}> " )
  [[ -z "$resource" ]] && return

  echo $resource
}
