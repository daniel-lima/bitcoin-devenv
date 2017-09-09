#!/bin/bash

set -xe

base_create_ssh_keys() {
    local SSH_KEY_FILE=$1
    local SSH_KEY_USER=$2
    
    test -n "${SSH_KEY_FILE}" -a -n "${SSH_KEY_USER}"
        
    cat <<'EOF' | { export SSH_KEY_FILE SSH_KEY_USER && su -c bash "${BASE_SYSTEM_USER}"; }
set -xe

test -d "${HOME}/.ssh" || { mkdir "${HOME}/.ssh" && chmod 700 "${HOME}/.ssh"; }

SSH_KEY_FILE="${HOME}/.ssh/${SSH_KEY_FILE}"
if [ ! -f "${SSH_KEY_FILE}" ]; then
    ssh-keygen -t rsa -b 4096 -C "${SSH_KEY_USER}" -f "${SSH_KEY_FILE}" -N ''
    chmod 600 "${SSH_KEY_FILE}"
fi

# Add the key to the SSH agent
eval $(ssh-agent -s)
ssh-add "${SSH_KEY_FILE}"
EOF
    
}

base() {
    apt-get -qq update && apt-get -y install apt-utils
    
    apt-get -y install openssh-client
    
    base_create_ssh_keys "${BASE_SYSTEM_USER}_git" "${BASE_SYSTEM_USER}"
    
    apt-get -y install git
}

_run() {
    if [ -z "${_INC_ONLY}" ]; then
        while (( "$#" )); do
            eval "$1"
            shift
        done
    fi
}


export DEBIAN_FRONTEND=noninteractive

if [ -n "${SUDO_USER}" ]; then
    BASE_SYSTEM_USER=${SUDO_USER}
elif [ -n "${USER}" ]; then
    BASE_SYSTEM_USER=${USER}
else
    BASE_SYSTEM_USER=$(whoami)
fi


_run $*
