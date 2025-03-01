
Cross compiling the linux kernel on an Apple Silicon based Mac comes with some challenges. There are two main problems. macOs has a case-insensitive filesystem, this means that 'file.txt' & 'File.txt' are the same file on macOs. Linux on the other hand uses a case-sensitive filesystem here are 'file.txt' and 'File.txt' two completely different and unrelated files. In the source code of linux there are multiple files with the same name but other capitalized letters, when compiling this on macOs these files will be missing. To solve this problem we will compile and store the kernel in a virtual machine i.e. a docker container.

The other main problem is the fact that the compiled kernel image should be written to an ext4 filesystem. This is not supported on macOs, intel based Macs can however use virtualbox to write directly to external drives. This is functionality is not yet ported to an apple silicon version of the app. We will solve this by sending the image over the internet to the raspberry pi.


## First Things First

Before starting make sure your raspberry pi is setup and that you can ssh into it. You should also install docker and docker-compose on your Mac.

## Bringing up the build environment

  1. Bring up the cross-compile environment:

     ```

     docker-compose up -d

     ```

  2. Log into the running container:

     ```
     docker attach cross-compile
     ```
### Cross-compiling

1. Clone the linux repo:

     ```
     git clone --depth=1 https://github.com/raspberrypi/linux
     ```
  
  1. Run the following commands to make the .config file:

     ```

     cd linux
     compilekernel

     ```

## Editing the kernel source inside /build/linux

To connect to the NFS share, create a folder like `nfs-share` on your Mac and run the command:
  
```

sudo mount -v -t nfs -o vers=4,port=2049 127.0.0.1:/ nfs-share

```
## Copying built Kernel via remote SSHFS filesystem

```

PI_ADDRESS=10.0.100.170 copykernel

```


> Change the `PI_ADDRESS` here to the IP address of the Pi you're managing.

The script will reboot Pi, and once rebooted, your new kernel should be in place!


### credit:
This tutorial and the used scripts are adapted from Jeff Geerling.
https://github.com/geerlingguy/raspberry-pi-pcie-devices/tree/master

For more information on (cross-) Compiling the linux kernel for the Raspberry pi visit: 
https://www.raspberrypi.com/documentation/computers/linux_kernel.html