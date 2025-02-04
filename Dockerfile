ARG JENKINS_INBOUND_AGENT_VERSION='bookworm-jdk21'

FROM jenkins/inbound-agent:${JENKINS_INBOUND_AGENT_VERSION}

USER root

RUN apt update

# Install git
RUN apt install -y git-all

# Configure docker repositories
# Add Docker official GPG key:
RUN apt update
RUN apt install ca-certificates curl
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "${VERSION_CODENAME}") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt update

# Install docker
RUN apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin

# Install kubectl
# Download binary
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# Verify the download
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
RUN echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install envsubst
RUN apt install -y gettext

# Install jq
RUN apt install -y jq
