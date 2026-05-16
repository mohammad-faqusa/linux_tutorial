## 228. Extra lecture (optional): Software Flexibility with Snap on CentOS and RHEL

### package management with snap 
* there is a problem that all dependencies must be installed globally 
  * snap solve this 
    * we bundle the application and its dependencies 
    * the download might be larger 
    * but allows each application can have different dependencies 
    * packages are updates automatically in the background (snapd)

### how snap package works 
* cnetralized repo for complete applications 
* needs trust the authers 
* we can look available packages htere (snapcraft.io)
* epel must be activated for this 
* dnf install snapd 
* systemctl enable --now snapd.service