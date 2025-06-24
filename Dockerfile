FROM jenkins/inbound-agent:3309.v27b_9314fd1a_4-1-jdk21

USER root

RUN apt update

# Install git
RUN apt install -y git-all

# Install kubectl
RUN apt install -y apt-transport-https ca-certificates curl gnupg \
  && mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
  && chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
  && echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list \
  && chmod 644 /etc/apt/sources.list.d/kubernetes.list \
  && apt update
RUN apt install -y kubectl

# Install helm
ARG HELM_VERSION="v3.18.3"
RUN curl -LO "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" \
  && tar -zxvf "helm-${HELM_VERSION}-linux-amd64.tar.gz" \
  && mv linux-amd64/helm /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm \
  && rm -rf linux-amd64* helm-${HELM_VERSION}-linux-amd64.tar.gz
