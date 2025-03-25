# Final Exam Exercise: Cloud Computing Performance Testing
<div><h3>Author: Valeria De Stasio SM3800074 </h3></div>

# Table of contents
- [Introduction](#introduction)
- [Virtual Machines Setup](#virtual-machines-setup)
  - [Create template of the virtual machine](#create-template-of-the-virtual-machine)
- [Configure master node](#configure-master-node)
  - [Configure SSH connection](#configure-ssh-connection)
  - [Configure internal network](#configure-internal-network)
  - [Change host name](#change-host-name)
  - [Configure connection to other hosts](#configure-connection-to-other-hosts)
  - [Configure master as DNS and DHCP](#configure-master-as-dns-and-dhcp)
  - [Configure master as NAT](#configure-master-as-nat)
  - [Configure shared filesystem](#configure-shared-filesystem)
- [Configure worker nodes](#configure-worker-nodes)
  - [Change worker node name](#change-worker-node-name)
  - [Configure SSH connection](#configure-ssh-connection-worker)
  - [Configure network settings](#configure-network-settings)
  - [Configure shared filesystem (automatically)](#configure-shared-filesystem-automatically)
  - [Changing the machine ID](#changing-the-machine-id)
- [Useful remark for executing code on multiple machines](#useful-remark-for-executing-code-on-multiple-machines)
- [Containers Setup](#containers-setup)
- [Performance Test](#performance-test)
  - [CPU test: HPC Challenge (HPCC)](#cpu-test-hpc-challenge-hpcc)
  - [Memory/CPU usage: stress-ng](#memorycpu-test-stress-ng)
  - [General system test: sysbench](#memorycpu-test-sysbench)
  - [Disk I/O test: IOZone](#disk-io-test-iozone)
  - [Network test: iperf](#network-test-iperf)
- [Analysis and comparison of VMs and containers results](#analysis-and-comparison-of-vms-and-containers-results)
  - [HPCC](#hpcc)
  - [Stress-ng](#stress-ng)
  - [IOZone](#iozone)
    - [Virtual Machines](#virtual-machines)
    - [Containers](#containers)
  - [Iperf](#iperf)
  - [Concluding Remarks](#concluding-remarks) 

# Introduction
The objective of this project is to evaluate and compare the overall performance of virtual machines (VMs) and containers. To do so, I decided to set up a cluster using [VirtualBox](https://www.virtualbox.org/) as the virtualization software and [Docker](https://www.docker.com/) for containerization, then execute the same performance tests in both settings.

> **Remark:** This whole project was conducted on the following host machine:
>- CPU: AMD Ryzen 7 7730U
>- RAM: 16 GB
>- OS: Windows 11
>Some steps related to VirtualBox and Docker software may >differ depending on the operating system and architecture. 

# Virtual Machines Setup
First, I decide my network topology. I want to create two worker nodes connected to a virtual switch and a master node that will work as the router, as the DNS and as the DHPC server. This topology enhances security, as only the master node will be directly connected to the internet, allowing us to configure it to filter messages from outside the internal net.

## Create template of the virtual machine
I started by creating a template virtual machine that would be used as the starting point for all nodes, workers and master alike.
To do so, it is sufficient to open VirtualBox and click on the "New" option. Then, following the installation process, it is possible to define all features of the desired virtual machine. 

I assigned 2 CPUs cores, 2 GB of RAM and 30 GB of hard disk to the template virtual machine. The image used was the Ubuntu server Long Term Support [24.04.2 LTS](https://ubuntu.com/download/server). I decided to use the server image instead of the desktop image to obtain a better performance of the cluster by avoiding a non-necessary user interface.

I chose *User* as the hostname and *cloud* as password, this will be common to all nodes for semplicity.

After creating the virtual machine and starting it, I executed the following commands: 
```bash
sudo apt update 
sudo apt upgrade 
sudo apt install -y openssh-server 
sudo systemctl start ssh 
sudo systemctl enable ssh 
sudo apt install -y net-tools gcc make 
sudo shutdown -h now 
```

Before shutting down, I can also check the IP assigned to the virtual machine by executing:
```bash
hostname -I
```

Now that I have a the template for a working virtual machine, I can clone it to obtain my nodes.

## Configure master node
Clone once the virtual machine and name it Master. This will be the master node and so the only node connected directly to internet.

### Configure SSH connection

On VirtualBox I open:
VM settings ->+ Network -> Advanced -> Port Forwarding

and I create a forwarding rule from host to the Master VM:
```
Name --> ssh
Protocol --> TCP
HostIP --> 127.0.0.1
Host Port --> 4022 
Guest Port --> 22
```
I leave "Guest IP" empty.

So now I can connect to my clone by the Windows command line:
```bash
ssh -p 4022 User@127.0.0.1
```

To make the connection passwordless I need to first generate a ssh key in the host that is going to access and to add its key to the list of authorized_keys in the host that is going to be accesed.
In my case, I want the master to be able to connect without the password to the worker nodes, so I execute the following command in the master node:
```bash
ssh-keygen
```

And I hit enter at all subsequent choices.
This will generate a key in a file named "id_number.pub" in the directory .ssh/.
I access in the worker nodes and copy the content of this file inside the file "authorized_keys" in the directory .ssh/.

To exit a machine I accessed via ssh I can simply execute:
```bash
exit
```
### Configure internal network

I add a new network adapter on the machine: enable "Adapter 2" "Attached to" internal network and name it "CloudBasicNet".

Now I start the master virtual machine, I connect through ssh (or directly using virtual box) and I execute:
```bash
ip link show
```
With this command I obtain all network interfaces of my master node.

I am interested in the second interface since it's the one that is connected to the internal network. 
It will be a name like *enp0s8*.

Since I've chosen an internal network I can freely choose the IPs I prefer: I chose the network 192.168.56.0/24, for a total of 253 possible hosts.

```bash
sudo vim /etc/netplan/50-cloud-init.yaml
```
I modify the file to obtain:
```
# This is the network config written by 'subiquity'
network:
  ethernets:
    enp0s3:
      dhcp4: true
    enp0s8:
     dhcp4: false
     addresses: [192.168.56.1/24]
  version: 2
```
Then I apply the changes:
```bash
sudo netplan apply
```
Now my master node has correctly been associated to the first IP of the network: it will act as the gateway for my cluster.

### Change host name

To design it as the master node, I change the name of the host:
```bash
sudo vim /etc/hostname
```

I modify the file to obtain:
```
master
```

To apply the change now I need to reboot!
```bash
sudo reboot
```

### Configure connection to other hosts

I edit the hosts file to assign names to my own IP:
```bash
sudo vim /etc/hosts
```
I modify the file to obtain:
```
127.0.0.1 localhost
127.0.1.1 Master
192.168.56.1 Master
```

### Configure master as DNS and DHCP
To configure the master node to act as a DNS and DHPC server I need to install some additional packages and edit some configuration files.

```bash
sudo apt update
sudo apt upgrade
sudo apt install dnsmasq -y
sudo vim /etc/dnsmasq.conf
```
I uncomment various lines in the dnsmasq.conf file:
```
bogus-priv
resolv-file=/etc/resolv.dnsmasq
listen-address=127.0.0.1, 192.168.56.1
bind-interfaces
dhcp-range=192.168.56.2,192.168.56.254,12h
dhcp-option=option:router,192.168.56.1
dhcp-option=option:dns-server,192.168.56.1
cache-size=1000
log-queries
```
Before editing the resolv.conf file, I unlink it. This is needed because, if the file is a symbolic link, then I wouldn't be able to modify it directly.

```bash
sudo unlink /etc/resolv.conf
sudo vim /etc/resolv.conf
```
I modify the file to obtain:
```
nameserver 127.0.0.1
options edns0 trust-ad
search .
```
Then I link again the resolv.conf file that I modified and I enable the service as dns:
```bash
sudo ln -s  /run/systemd/resolve/resolv.conf /etc/resolv.dnsmasq
sudo systemctl enable dnsmasq
sudo systemctl restart dnsmasq systemd-resolved
sudo systemctl restart dnsmasq # I execute it after any changes, if I need them
```

Check:
```bash
host google.com
```

### Configure master as NAT
I enable IP forwarding to allow routing between networks by executing the following commands:
```bash
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
sudo nano /etc/sysctl.conf
```
In the file, uncomment the following line to enable IP forwarding:
```
net.ipv4.ip_forward = 1
```
Now I set up the NAT and routing rules using iptables:
```bash
sudo sysctl -p
sudo iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
sudo iptables -A FORWARD -i enp0s8 -o enp0s3 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i enp0s3 -o enp0s8 -j ACCEPT
sudo apt install iptables-persistent
sudo netfilter-persistent save
```

In the end I save the iptables rules for persistence across reboots.

### Configure shared filesystem 
I set up a shared directory that can be accessed by other nodes over the network.
```bash
sudo apt install nfs-kernel-server
sudo mkdir /shared
sudo chmod 777 /shared
```
I configure the NFS exports:
```bash
sudo vim /etc/exports
```
```
/shared 192.168.56.0/255.255.255.0(rw,sync,no_root_squash,no_subtree_check)
```
Finally, I restart the NFS server.
```bash
sudo systemctl enable nfs-kernel-server 
sudo systemctl restart nfs-kernel-server
```

-----------------------------------------------------------------------------------------------------------------------

## Configure worker nodes
First of all I assure that the mac address of the network adapter is different.
Then I change the adapter 1 network to internal network and select the CloudBasicNet previously defined.

We change the name of the worker node:
```bash
sudo vim /etc/hostname
```
I modify the file to obtain:
```
NodeX
```
And then I reboot, just like with the master node!

Now I can access via ssh to the node. To do so I just need to enter via ssh to the master node and then enter to the worker node using:
```bash
ssh NodeX
```
I want the workers to be able to connect without the password to the master, so I execute the following command in the worker node:
```bash
ssh-keygen
```

And I hit enter at all subsequent choices.
This will generate a key in a file named "id_number.pub" in the directory .ssh/.
I access in the master node and copy the content of this file inside the file "authorized_keys" in the directory .ssh/.

On the worker nodes I also write:
```bash
sudo vim .ssh/config
```
I modify the file to obtain:
```
Host Master
    HostName 192.168.56.1
    User User
    IdentityFile ~/.ssh/id_ed255
```

This way, I am sure that when the worker tries to connect to the master via hostname resolution or via IP it will use the key I previously generated.

I then edit the hosts file to assign names to my own IP and Master to the master IP as follows:
```bash
sudo vim /etc/hosts
```
```
127.0.0.1 localhost
127.0.1.1 NodeX
192.168.56.1 Master
```

To configure the connection to the master node
```bash
sudo vim /etc/netplan/50-cloud-init.yaml
```
I modify the file to obtain:
```
# This is the network config written by 'subiquity'
network:
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: true
      dhcp-identifier: mac
      routes:
        - to: 0.0.0.0/0
          via: 192.168.56.1
      nameservers:
        addresses: [192.168.56.1]
  version: 2
```

```bash
sudo netplan apply
```

```bash
sudo unlink /etc/resolv.conf
sudo vim /etc/resolv.conf
```
I modify the file to obtain:
```
nameserver 192.168.56.1
options edns0 trust-ad
search .
```

Now I can execute some final checks before moving to the performance testing.

From NodeX:
```bash 
ip a  # Should show DHCP-assigned IP (192.168.56.x)
ping 8.8.8.8  # Should work if NAT is correct
ping google.com
ping Master
ping NodeY
```

From master:
```bash 
ip a  
ping 8.8.8.8 
ping google.com
ping NodeX
ping NodeY
```

### Configure shared filesystem (automatically)
I install autofs for automatic NFS mounting:
```bash
sudo apt install autofs
sudo vim /etc/auto.master
```
```
/- /etc/auto.mount
```
The I create and edit the auto-mount configuration:
```bash
sudo vim /etc/auto.mount
```

```
/shared -fstype=nfs,rw 192.168.56.1:/shared
```
Finally, restart autofs to apply the changes:
```bash
sudo systemctl restart autofs
```

Now I can test the shared file system by creating a file in the shared directory from inside a node and checking if it appeared in the master node.

After configuring one node I can just clone it to have the others! But I have to remember to change the hostname and the mac address of the network adapter and potentially the machine ID. In my case, I just cloned it once to have a second worker node.

## Changing the machine ID (potential problem for systemd-resolved)

Check if equal:
```bash
cat /etc/machine-id
```
If they are equal, I can easily change one of the two hosts by executing:
```bash
sudo rm -f /etc/machine-id
sudo systemd-machine-id-setup
sudo reboot
```

# Useful remark for executing code on multiple machines
Inside the virtual machine I can use the following command to visualize multiple terminals on the same screen: 
```bash
tmux # to enter the state with multiple terminals
ctrl+b # Before every tmux specific command
ctrl+b & shift+5 # To create a terminal on the right of the current one
ctrl+b & shift+2 # To create a terminal under the current one
ctrl+b & x # To kill a terminal
exit # To exit a terminal
```

# Containers Setup

Now I use Docker to create the conteneirized cluster. In this case the containers are connected using an internal Docker network.

I create the dockerfile:
```
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
```

And I create the docker-compose.yaml:

```
services:

  master:
    build: .
    container_name: Master
    hostname: Master
    networks:
      - my_network
    deploy:
      resources:
        limits:
          cpus: "2"
          memory: 2G
    ports:
      - "2220:22"
    volumes:
      - shared_volume:/shared:mode=777
  
  node01:
    build: .
    container_name: Node01
    hostname: Node01
    networks:
      - my_network
    deploy:
      resources:
        limits:
          cpus: "2"
          memory: 2G
    ports:
      - "2221:22"
    volumes:
      - shared_volume:/shared:mode=777

  node02:
    build: .
    container_name: Node02
    hostname: Node02
    networks:
      - my_network
    deploy:
      resources:
        limits:
          cpus: "2"
          memory: 2G
    ports:
      - "2222:22"
    volumes:
      - shared_volume:/shared:mode=777

networks:
  my_network:
    driver: bridge

volumes:
  shared_volume:
    driver: local
```

Then I execute:
```bash
docker-compose build -d
docker exec -it Master bash
```
This way I have created 3 containers connected by an internal network: Master, Node01 and Node02.
When I am inside the master I manually try all combinations to assure ssh works passwordless between all pairs of nodes.

```bash
ssh Node01
ssh Node02
ssh Master
ssh Node02
ssh Node01
ssh Master
exit
exit
exit
exit
exit
```

If I have any problems with the read/write permissions on the common shared directory I can enforce permission by executing the following commands:
```bash
sudo chmod -R 777 /shared
chown -R user:user /shared
```


# Performance Test
This first set up is needed only for the virtual machines (since in the Dockerfile I already installed all the packages for the testing).

On all nodes execute:
```bash
sudo apt update
sudo apt upgrade
sudo apt install iperf3 stress-ng iozone3 sysbench hpcc mpich
```
I decided to not set iperf as a daemon at boot time when asked.
We are installing mpich (version of mpi) to send the test command in parallel to all worker nodes of the cluster so that they are all stressed at the same time.

## CPU test: HPC Challenge (HPCC)

The HPC Challenge benchmark consists of 7 benchmarks: HPL, STREAM, RandomAccess, PTRANS, FFTE, DGEMM and b_eff Latency/Bandwidth.

1) HPL - the Linpack TPP benchmark which measures the floating point rate of execution for solving a linear system of equations.
2) DGEMM - measures the floating point rate of execution of double precision real matrix-matrix multiplication.
3) STREAM - a simple synthetic benchmark program that measures sustainable memory bandwidth (in GB/s) and the corresponding computation rate for simple vector kernel. Stream will be run in two variants:
* Single STREAM: test run on single processor
* Star STREAM: test run on multiple processors
4) PTRANS (parallel matrix transpose) - exercises the communications where pairs of processors communicate with each other simultaneously. It is a useful test of the total communications capacity of the network.
5) RandomAccess - measures the rate of integer random updates of memory (GUPS). RandomAccess will be run in three variants: 
* Single RandomAccess: single process.
* Star RandomAccess: all processes perform identical to single process with no interactions.
* MPI RandomAccess: all processes cooperate to solve a larger problem.
6) FFT - measures the floating point rate of execution of double precision complex one-dimensional Discrete Fourier Transform (DFT). FFT will be run in three variants: 
* SingleFFT: single process.
* Star FFT: parallel routines for shared-memory parallel hardware.
* MPI FFT:  parallel routines for distributed-memory parallel hardware, where each CPU has its own separate memory. 
7) Communication bandwidth and latency - a set of tests to measure latency and bandwidth of a number of simultaneous communication patterns; based on b_eff (effective bandwidth benchmark).


On master node:
```bash
sudo mkdir /shared
cd /shared
sudo vim hpccinf.txt
```
I modify the file to obtain:
```
HPLinpack benchmark input file
Innovative Computing Laboratory, University of Tennessee
HPL.out      output file name (if any) 
6            device out (6=stdout,7=stderr,file)
1            # of problems sizes (N)
20352         Ns
1            # of NBs
192           NBs
0            PMAP process mapping (0=Row-,1=Column-major)
1            # of process grids (P x Q)
1            Ps
2            Qs
16.0         threshold
1            # of panel fact
2            PFACTs (0=left, 1=Crout, 2=Right)
1            # of recursive stopping criterium
4            NBMINs (>= 1)
1            # of panels in recursion
2            NDIVs
1            # of recursive panel fact.
1            RFACTs (0=left, 1=Crout, 2=Right)
1            # of broadcast
1            BCASTs (0=1rg,1=1rM,2=2rg,3=2rM,4=Lng,5=LnM)
1            # of lookahead depth
1            DEPTHs (>=0)
2            SWAP (0=bin-exch,1=long,2=mix)
64           swapping threshold
0            L1 in (0=transposed,1=no-transposed) form
0            U  in (0=transposed,1=no-transposed) form
1            Equilibration (0=no,1=yes)
8            memory alignment in double (> 0)
##### This line (no. 32) is ignored (it serves as a separator). ######
0                               Number of additional problem sizes for PTRANS
1200 10000 30000                values of N
0                               number of additional blocking sizes for PTRANS
40 9 8 13 13 20 16 32 64        values of NB
```
I obtained this input file using [this website](https://www.advancedclustering.com/act_kb/tune-hpl-dat-file/) that was reccomended during the lessons. I specified I had 2 nodes on which to run the test (Node01 and Node02), that I would use one CPU each and that the 2 nodes have 2G of RAM each.

Then I specify in which nodes I'll run the test. This is needed for mpi.
```bash
sudo vim hosts
```
I modify the file to obtain:
```
Node01 slots=1
Node02 slots=1
```

```bash
mpirun -np 2 -hostfile hosts hpcc
```
We are launching the tests in two cores (one per node) instead of four. The HPCC benchmark performs intensive computing over the CPU,so deploying the tests in all the cores would cause kernel starvation.
The results can be found inside hpccoutf.txt in the same directory where I executed the command.



## Memory/CPU test: stress-ng

Stress-ng was designed to exercise various physical subsystems of a computer as well as the various operating system kernel interfaces.  
Stress-ng can run more than one stress test in parallel, in fact I decided to run two instances of each selected stressor at a time.
- CPU stressor: CPU intensive.
- VM stressor: Virtual memory stressor (paging and memory)
- HDD stressor: write/read to stress hard disk drive.

All tests are run for 60 seconds and output a file containing the bogo ops thanks to the flag *--metrics-brief*.

```bash
mpirun -np 2 -hostfile hosts stress-ng --cpu 2 --timeout 60s --metrics-brief | tee stress_ng_cpu_results.txt
mpirun -np 2 -hostfile hosts stress-ng --vm 2 --vm-bytes 1G --timeout 60s --metrics-brief | tee stress_ng_vm_results.txt
mpirun -np 2 -hostfile hosts stress-ng --hdd 1 --timeout 60s --metrics-brief | tee stress_ng_hdd_results.txt
```

## Memory/CPU test: sysbench
Sysbench is a multi-threaded benchmark tool that tests the system under complex workloads. 

On master node I execute:
```bash
mpirun -np 2 -hostfile hosts sysbench --test=cpu --cpu-max-prime=20000 run | tee sysbench_cpu_results.txt
mpirun -np 2 -hostfile hosts sysbench --test=memory --memory-total-size=10G run | tee sysbench_mem_results.txt
```
In this case I decided to test both the CPU and memory: the first command will benchmark the CPU by calculating prime numbers up to 20,000, while the second command will benchmark the memory on 10GB previously allocated.


## Disk I/O test: IOZone
IOzone performs 13 types of test (Read, Write, Re-read, Re-write, Random Read, Random Write, Backward Read, Record Re-Write, Stride Read, Fread, Fwrite, Freread, Frewrite).

First, I execute the test on the local filesystem with the following command:
```bash
iozone -a -R -O | tee iozone_results.txt
```
Then I execute the test on the shared filesystem with the following commands:
```bash
touch /shared/testfile
vim machines.txt
```
I modify the file to obtain:
```
Node01 /shared /usr/bin/iozone 
Node02 /shared /usr/bin/iozone
```

```bash
export ssh=rsh
iozone -+m /shared/machines.txt -f /shared/testfile -a -R -O | tee iozone_shared_results.txt
```

Iozone will generate an Excel compatible report to standard out.
>**RMK**: To get the graphs one needs to scroll down to the Excel portion of the file and graph the data in that section. When importing the file be sure to tell Excel to import with "delimited" and then click next, then click on the "space delimited" button. To graph the data just highlight the region containing the file size and record size and then click on the graph wizard. The type of graph used is "Surface". When the next dialog box pops up you need to select "Columns". After that the rest should be straight forward. 


## Network test: iperf
Iperf is a tool for active measurements of the maximum achievable bandwidth on IP networks, allowing for many tuning parameters.

On master node (server mode):
```bash
sudo killall iperf3 
iperf3 -s | tee iperf3_results.txt
```

On worker nodes (client mode):
```bash
iperf3 -c Master # TCP test
iperf3 -c Master -u #UDP test
iperf3 -c Master -R # Reverse test: the client receives
```
I test both TCP and UDP protocols, in the first case I check the bandwidth, while in the second case I check the packet loss and the delay jitter. I also check the inverse connection where the worker is on the receiving side and the master on the sending side.

> **Remark**:
If, for any reasons, the UDP test should fail I have to assure that both nodes connecting to each other have UDP enabled, by executing the following lines on both nodes:
> ```bash
> sudo iptables -A INPUT -p udp --dport 5201 -j ACCEPT
> sudo iptables -A OUTPUT -p udp --sport 5201 -j ACCEPT
> sudo apt install iptables-persistent # If not already installed
> sudo netfilter-persistent save
> ```

# Analysis and comparison of VMs and containers results
In each of the following sections I will report the obtained results for each test in both enviroments (virtual machines and containers) and provide a brief comparison of the metrics.

## HPCC
| Benchmark                  | VMs                     | Containers                 |
|----------------------------|-------------------------|----------------------------|
| **HPLinpack**              | 3.320 Gflops            | 5.548 Gflops               |
| **MPIRandomAccess**        | 0.0012 GUP/s            | 0.00242 GUP/s              |
| **StarRandomAccess**       | 0.0262 GUP/s          | 0.0262 GUP/s             |
| **SingleRandomAccess**     | 0.0458 Single GUP/s   | 0.0458 Single GUP/s      |
| **MPIRandomAccess_LCG**    | 0.00118 GUP/s       | 0.0025 GUP/s           |
| **StarRandomAccess_LCG**   | 0.0257 Average GUP/s  | 0.0356 Average GUP/s    |
| **SingleRandomAccess_LCG** | 0.0478 GUP/s          | 0.0612 GUP/s            |
| **PTRANS**                 | 1.108 GB/s              | 1.28364 GB/s               |
| **StarDGEMM**              | 1.7657 Gflop/s        | 2.4805 Gflop/s            |
| **SingleDGEMM**            | 1.6947 Gflop/s        | 3.1854 Gflop/s            |
| **StarSTREAM (Copy)**      | 8.7121 GB/s             | 8.5584 GB/s               |
| **StarSTREAM (Scale)**     | 4.7989 GB/s             | 5.3231 GB/s               |
| **StarSTREAM (Add)**       | 5.6724 GB/s             | 6.1122 GB/s               |
| **StarSTREAM (Triad)**     | 5.4813 GB/s             | 6.1341 GB/s               |
| **SingleSTREAM (Copy)**    | 15.4371 GB/s          | 17.6364 GB/s               |
| **SingleSTREAM (Scale)**   | 8.5237      GB/s               | 11.303 GB/s                |
| **SingleSTREAM (Add)**     | 10.1071 GB/s                    | 13.0912 GB/s               |
| **SingleSTREAM (Triad)**   | 10.173 GB/s                    | 13.21 GB/s                 |

- **GFlops**: Giga Floating Point Operations Per Second, how many billion floating-point calculations a system can perform per second.
- **GUP/s**: Giga Updates Per Second, how many billion memory updates (random accesses) can be performed per second.
- **GB/s**: Data transfer speed, used to evaluate memory bandwidth or inter-process communication performance.

From these results, we can see that containers consistently outperform VMs in every benchmark:

- HPLinpack, DGEMM, and RandomAccess tests show significant improvements in floating-point and memory performance.

- Memory bandwidth is better in containers, but the difference is smaller than in compute-intensive benchmarks.

- Parallel matrix operations (PTRANS) and RandomAccess tests suggest that inter-node communication is more efficient in containers.

Since both setups used the same hardware resources (2 nodes, 1 CPU each), the improved efficiency of containers suggests reduced virtualization overhead compared to VMs. So container-based cluster is more efficient than the VM-based one, especially for CPU-intensive and communication-heavy workloads.

## Stress-ng

This are the results for the CPU, VM and hdd test:

| Stressor | VMs | Containers |
|----------|---------|----------------------|
| CPU  - Bogo Ops   | 61304  |  80334|
|CPU - Bogo Ops/s (Real Time) | 1021.67             |1338.93|
| VM - Bogo Ops | 1953170  |4378298|
|VM - Bogo Ops/s (Real Time)| 32486.49      | 72758.82|
|hdd - Bogo Ops       |       55315 | 487717|
|hdd - Bogo Ops/s (Real Time)|       859.97| 8083.42|

- **Bogo Ops**: The number of "bogus operations" executed during the test. These are synthetic operations used to estimate performance.
- **Bogo Ops/s (Real Time)**: The rate of operations per second based on real elapsed time.

We can see that CPU-bound tasks are consistently executed more efficiently in containers than in VMs, even if the biggest performance gap is in HDD and memory operations where containers are over 7x faster than VMs.


## Sysbench
| Stressor | VMs | Containers |
|----------|------------|------|
|CPU event per second| 821.53| 1985.98|
|Memory write speed|3559.17 MiB/sec|8030.53 MiB/sec|

These results further show that containers have much better CPU and memory performance (specifically, they outperform VMs by over 100%), this is probably due to the virtualization overhead aforementioned.

## Iozone
Here I report only the metrics for the test on the shared filesystem.
I also decided to keep only the most common operations, the other test results are left in the github repository.

### Virtual Machines:

Writer report:
![alt text](https://raw.githubusercontent.com/CapraCampa/Cloud-Final-Project/main/image.png)

Re-writer report:
![alt text](https://raw.githubusercontent.com/CapraCampa/Cloud-Final-Project/main/image-1.png)

Reader report:
![alt text](https://github.com/CapraCampa/Cloud-Final-Project/blob/main/image-2.png)

Re-Reader report:
![alt text](https://raw.githubusercontent.com/CapraCampa/Cloud-Final-Project/main/image-3.png)

Random read report:
![alt text](https://raw.githubusercontent.com/CapraCampa/Cloud-Final-Project/main/image-4.png)

Random write report:
![alt text](https://raw.githubusercontent.com/CapraCampa/Cloud-Final-Project/main/image-5.png)

### Containers:

Writer report:
![alt text](https://raw.githubusercontent.com/CapraCampa/Cloud-Final-Project/main/image-6.png)

Re-writer report:
![alt text](https://raw.githubusercontent.com/CapraCampa/Cloud-Final-Project/main/image-7.png)

Reader report:
![alt text](https://raw.githubusercontent.com/CapraCampa/Cloud-Final-Project/main/image-8.png)

Re-Reader report:
![alt text](https://raw.githubusercontent.com/CapraCampa/Cloud-Final-Project/main/image-11.png)

Random read report:
![alt text](https://raw.githubusercontent.com/CapraCampa/Cloud-Final-Project/main/image-9.png)

Random write report:
![alt text](https://raw.githubusercontent.com/CapraCampa/Cloud-Final-Project/main/image-10.png)

We can notice that the overall shapes and patterns are largely the same for VMs and continers: high throughput on smaller (cache‐friendly) data sets, then a drop and leveling off for larger record sizes/files. Because this is a shared filesystem across two nodes, we are also dealing with potential network/metadata overheads: this could overshadow any performance differences between containers versus VMs on local disks and be the reason for the similar performances. 

>**RMK**: In alternative, to get accurate results for the entire range of performance I could have increased the maximum file size to be tested to assure that it was bigger than the buffer cache. This is adviced also in the IOZone documentation.


## Iperf
| Metric                                | VMs              | Containers
|---------------------------------------|----------------------|------|
| **Upload speed (TCP)**                | 1.80 Gbits/sec       |23.6 Gbits/sec|
| **Download speed (TCP - reverse mode)**| 2.33 Gbits/sec       |22.3 Gbits/sec|
| **Jitter (UDP)**                      | 0.090 ms             |0.145 ms|
| **Packet loss (UDP)**                 | 0%                   |0% |

From these results we can see that TCP upload/dowload speed is 10x faster in the containers, suggesting a significant network overhead in the virtual machines. For the UDP coonection instead we see a much more similar performance in the two settings.

# Concluding remarks

All the test results were consistent between each other: in most cases (especially for CPU and memory performance) there was a clear improvement in the containerized cluster over the virtualized cluster. It still stands that virtualized enviroments provide a better isolation from the host system, but the increased performance and more simple customization of containers justifies their increased popularity over the years.