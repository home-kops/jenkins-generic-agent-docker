FROM jenkins/inbound-agent:3309.v27b_9314fd1a_4-1-jdk21

USER root

RUN apt update

# Install git
RUN apt install -y git-all

# Install kubectl
# Download binary
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# Verify the download
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
RUN echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install helm
ARG HELM_VERSION="v3.18.3"
RUN curl -LO "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" \
  && tar -zxvf "helm-${HELM_VERSION}-linux-amd64.tar.gz" \
  && mv linux-amd64/helm /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm \
  && rm -rf linux-amd64* helm-${HELM_VERSION}-linux-amd64.tar.gz
