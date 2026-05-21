# 300. The Tool Wireshark: Monitoring Network Traffic (incl. Ethical Considerations)

# legal disclaimer

## important

```text id="wireshark001"
this is not legal advice
```

Laws regarding network monitoring differ:

* by country
* by organization
* by workplace policies

---

# what Wireshark can do

Wireshark is a very powerful network analysis tool.

It can:

* capture packets
* inspect traffic
* analyze protocols
* reconstruct communications
* troubleshoot networking

---

# important ethical consideration

Wireshark can capture:

* usernames
* passwords
* cookies
* emails
* visited websites
* unencrypted traffic

Thus:

```text id="wireshark002"
capturing traffic belonging to others may be illegal or unethical
```

---

# important security note

Even when technically possible:

```text id="wireshark003"
you should only inspect traffic you are authorized to analyze
```

Examples of ethical usage:

* personal learning
* troubleshooting your devices
* lab environments
* authorized penetration testing
* educational use

---

# unsafe or illegal usage examples

Potentially illegal:

* monitoring coworkers without permission
* capturing public WiFi user traffic
* intercepting credentials
* spying on networks

---

# the software: Wireshark

Wireshark is:

```text id="wireshark004"
a graphical packet analyzer
```

It allows visualization of:

* packets
* protocols
* requests
* responses
* network flows

Very widely used in:

* Linux administration
* cybersecurity
* networking
* DevOps
* backend troubleshooting

---

# installation on Ubuntu

Install package:

```bash id="wireshark005"
sudo apt install wireshark
```

---

# important installation prompt

During installation:

```text id="wireshark006"
you may be asked whether non-root users can capture packets
```

If enabled:

* user added to:

```text id="wireshark007"
wireshark
```

group.

---

# applying group changes

After adding user:

```bash id="wireshark008"
sudo usermod -aG wireshark $USER
```

Then:

* logout/login

or:

```bash id="wireshark009"
newgrp wireshark
```

---

# starting Wireshark

Launch GUI:

```bash id="wireshark010"
sudo wireshark
```

or if permissions configured:

```bash id="wireshark011"
wireshark
```

---

# selecting interfaces

Wireshark shows available interfaces:

Examples:

* Ethernet
* WiFi
* loopback
* Docker interfaces
* VPN interfaces

---

# common interface names

Examples:

| Interface | Meaning  |
| --------- | -------- |
| enp0s3    | Ethernet |
| wlp2s0    | WiFi     |
| lo        | loopback |

---

# starting packet capture

Choose interface:

* double-click interface
* capture begins immediately

You will see:

```text id="wireshark012"
continuous packet flow
```

---

# generating traffic for testing

Examples:

* open browser
* visit website
* ping server
* run curl command

Wireshark captures related packets.

---

# example experiment

Open:

```text id="wireshark013"
google.com
```

Then observe:

* DNS requests
* TCP connections
* TLS handshake
* HTTPS traffic

---

# filtering packets

Very important feature.

Example filter:

```text id="wireshark014"
dns
```

Shows:

* DNS traffic only

---

# HTTP filter

```text id="wireshark015"
http
```

Shows:

* HTTP packets

---

# HTTPS/TLS filter

```text id="wireshark016"
tls
```

Shows:

* encrypted HTTPS traffic

---

# ICMP filter

```text id="wireshark017"
icmp
```

Useful for:

* ping traffic

---

# filtering by IP

Example:

```text id="wireshark018"
ip.addr == 8.8.8.8
```

Shows packets involving:

```text id="wireshark019"
8.8.8.8
```

---

# following streams

Very useful feature.

Right click packet:

```text id="wireshark020"
Follow → TCP Stream
```

Allows:

* reconstructing communication flow

---

# understanding packet structure

Each packet contains layers:

| Layer        | Example       |
| ------------ | ------------- |
| Ethernet     | local network |
| IP           | addressing    |
| TCP/UDP      | transport     |
| HTTP/DNS/TLS | application   |

Wireshark visualizes all layers.

---

# example packet flow when opening website

## Step 1

DNS query:

```text id="wireshark021"
what is google.com's IP?
```

---

# Step 2

DNS response:

```text id="wireshark022"
returns IP address
```

---

# Step 3

TCP handshake:

```text id="wireshark023"
connection establishment
```

---

# Step 4

TLS handshake:

```text id="wireshark024"
secure encrypted session setup
```

---

# Step 5

HTTPS requests/responses

---

# important educational value

Wireshark helps visualize:

```text id="wireshark025"
how networking actually works internally
```

Very useful for:

* debugging
* learning protocols
* understanding internet communication

---

# common professional uses

Wireshark used for:

* diagnosing slow networks
* debugging APIs
* analyzing DNS problems
* troubleshooting TLS issues
* inspecting packet loss
* investigating latency
* malware analysis
* protocol development

---

# command-line alternative

Wireshark also has CLI counterpart:

```bash id="wireshark026"
tshark
```

Useful for:

* servers
* SSH environments
* automation

---

# capturing only specific traffic

Example:

* only DNS
* only one interface
* only one IP
* only TCP

This reduces noise.

---

# important note about encrypted traffic

Modern HTTPS traffic:

```text id="wireshark027"
usually encrypted
```

Meaning:

* contents hidden
* but metadata still visible:

  * destination IP
  * ports
  * packet sizes
  * timing

---

# common beginner mistake

Many beginners expect:

```text id="wireshark028"
to read all HTTPS website contents
```

Usually impossible without:

* decryption keys
* MITM setup
* browser SSL logging

---

# useful Linux networking relationship

Wireshark complements tools like:

| Tool       | Purpose                   |
| ---------- | ------------------------- |
| ping       | latency testing           |
| traceroute | routing path              |
| ip         | interface/routing config  |
| ss         | sockets/connections       |
| tcpdump    | CLI packet capture        |
| Wireshark  | graphical packet analysis |

---

# useful commands summary

Install:

```bash id="wireshark029"
sudo apt install wireshark
```

Launch:

```bash id="wireshark030"
wireshark
```

Add user to group:

```bash id="wireshark031"
sudo usermod -aG wireshark $USER
```

CLI version:

```bash id="wireshark032"
tshark
```

Useful filters:

```text id="wireshark033"
dns
http
tls
icmp
ip.addr == 8.8.8.8
```
