FROM quay.io/fedora/fedora-silverblue:latest
RUN curl -s https://raw.githubusercontent.com/Emblem-66/ServerBlue/refs/heads/main/Instructions.sh | bash && rm -rf /tmp/* /var/* && ostree container commit
