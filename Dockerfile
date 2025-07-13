FROM ubuntu:24.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y gnupg2 python3-pip python3-venv sshpass git openssh-client && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN python3 -m venv /opt/venv &&     /opt/venv/bin/pip install --upgrade pip cffi &&     /opt/venv/bin/pip install ansible-core==2.18.6 &&     /opt/venv/bin/pip install ansible==9.3.0 ansible-lint==25.6.1 &&     /opt/venv/bin/pip install mitogen jmespath &&     /opt/venv/bin/pip install --upgrade pywinrm &&     rm -rf /root/.cache/pip

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /ansible

CMD [ "ansible-playbook", "--version" ]
