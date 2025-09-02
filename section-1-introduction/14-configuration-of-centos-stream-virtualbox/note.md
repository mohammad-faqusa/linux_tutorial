## 14. Configuration of CentOS Stream [VirtualBox]


### requirements : 
* install drivers 
    * update our system 
    * install additional ways to fetch software 
    * update our system (one more time)
    * install tools required to compile the drivers 
    * install the drivers 

### the process 
1. go to activities 
2. terminal 
3. change font 
```bash
sudo dnf update  
```
* recommended to reboot the system for some updates
```bash
sudo dnf install epel-release
sudo dnf update 
sudo dnf install gcc kernal-devel kernel-headers make bzip2 perl 
```
4. install additional drivers 
   * devices -> insert disk CD 
   * allow and type password 
   * in case don't work : 
     * go to file browser 
     * go to cd driver 
     * sudo (VBoxLinuxAdditions.run)
5. the mouse cursor is fixed, and easily change the window size
6. device -> enable share bidirectional 
   * try copy and paste texts between the machines 
7. drag and drop (bidirectional)
8. configure shared folder