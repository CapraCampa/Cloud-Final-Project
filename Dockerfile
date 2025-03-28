# Start from the base Ubuntu image
FROM ubuntu:latest

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    openssh-server rsync iputils-ping \
    sysbench stress-ng iozone3 iperf3 \
    netcat-openbsd wget unzip hpcc \
    mpich vim \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create SSH folder and set correct permissions
RUN mkdir -p /var/run/sshd /home/user/.ssh /shared/results \
    && chmod 700 /home/user/.ssh

# Create a new user 'user' with a home directory
RUN useradd -m -s /bin/bash user \
    && echo "user:cloud" | chpasswd \
    && echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Generate SSH keys for user (only if they do not already exist)
RUN if [ ! -f /home/user/.ssh/id_rsa ]; then \
      ssh-keygen -t rsa -N '' -f /home/user/.ssh/id_rsa; \
    fi && \
    cat /home/user/.ssh/id_rsa.pub >> /home/user/.ssh/authorized_keys && \
    chmod 600 /home/user/.ssh/id_rsa /home/user/.ssh/authorized_keys && \
    chown -R user:user /home/user/.ssh

# Expose SSH port
EXPOSE 22

# Switch to user
USER user
WORKDIR /home/user

# Start SSH service correctly with host key generation
CMD sudo /usr/sbin/sshd -D -e
