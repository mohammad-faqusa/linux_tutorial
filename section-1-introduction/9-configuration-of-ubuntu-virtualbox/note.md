## 9. Configuration of Ubuntu [VirtualBox]

### Configuring Ubuntu 
* we need to install some drivers to run smoothly 
* for this : 
  * update our system 
  * install tools required to compile drivers 
  * install drivers 

### the process 

#### problem : 
1. moving files between the virtaul machine and the host machine

#### solution : 
1. go to terminal 
```bash
sudo apt update 
sudo apt full-upgrade 
```
2. restart the VM 
3. back to terminal 
```bash
sudo apt install build-essential linux-headers-generic dkms 
#confirm with y 
```
4. on virtaul box menu : 
   1. click on devices 
   2. insert Gest Addition CD image 
   3. inside the cd : 
      * VBoxLinuxAddition.run // ececute from the terminal 
      * by typing `sudo` , and drag and drop the file on terminal 
   4. restart VM 
5. on VBox menu, 
   1. devices 
   2. drag and drop 
   3. bidirectional 
4. try copy paste the text between the two machines 
5. from menu: 
   1. devices 
   2. share folders 
   3. select the folders allowed to share 
   4. 