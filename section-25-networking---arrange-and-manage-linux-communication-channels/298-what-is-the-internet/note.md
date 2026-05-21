# 298. What is the Internet?

# what is the internet?

The internet is:

```text id="internet001"
a huge interconnected network of computers and networking devices
```

These devices are called:

* nodes

Examples:

* computers
* routers
* servers
* switches
* phones
* cloud machines

---

# key idea

The internet forms:

```text id="internet002"
a massive mesh of interconnected networks
```

Meaning:

* devices connected through MANY possible paths

Not:

```text id="internet003"
one single cable connecting everybody
```

---

# main goal of the internet

The internet allows:

```text id="internet004"
communication with almost any other computer
```

without:

* direct dedicated cable between them.

Example:

* your laptop in Palestine
* communicates with Google servers in another country

without:

```text id="internet005"
direct physical connection
```

---

# another important goal

Redundancy and fault tolerance.

If:

* one cable cut
* one router fails
* one provider down

then:

```text id="internet006"
traffic can often find another path
```

This is one of the biggest strengths of the internet.

---

# basic visualization

Typical communication path:

```text id="internet007"
Your Computer
    ↓
Home Router
    ↓
ISP Routers
    ↓
Internet Backbone
    ↓
Google Routers
    ↓
Google Server
```

Many routers between source and destination.

---

# how communication works

Data is NOT usually sent:

```text id="internet008"
as one huge continuous stream
```

Instead:

```text id="internet009"
data split into packets
```

---

# what is a packet?

A packet is:

```text id="internet010"
small chunk of data
```

containing:

* payload (actual data)
* source IP
* destination IP
* protocol information

---

# example

Suppose you open:

```text id="internet011"
google.com
```

Your browser:

* sends packets
* to Google's IP address

---

# important question

How do we know Google's IP address?

Answer:

```text id="internet012"
DNS
```

---

# DNS role

DNS:

```text id="internet013"
translates domain names into IP addresses
```

Example:

```text id="internet014"
google.com
→
142.250.x.x
```

Humans use names.
Routers use:

```text id="internet015"
IP addresses
```

---

# router role

Routers:

```text id="internet016"
forward packets toward destination
```

They examine:

* destination IP address

then decide:

```text id="internet017"
where packet should go next
```

using:

* routing tables
* network maps

---

# important concept

Routers usually:

```text id="internet018"
do NOT know entire internet perfectly
```

Instead:

* each router knows:

  * where to forward certain ranges of IPs

Like:

```text id="internet019"
road intersections forwarding cars
```

---

# how packet reaches your home router

Excellent question from your note.

Your computer first needs:

```text id="internet020"
a local connection to home router
```

Usually through:

* Ethernet cable
* WiFi

---

# local network communication

Inside your home:

* laptop
* router
* phone

form:

```text id="internet021"
a local network (LAN)
```

Your computer sends packet:

```text id="internet022"
to default gateway
```

which is usually:

```text id="internet023"
your home router
```

---

# how computer knows router address

Usually via:

```text id="internet024"
DHCP
```

DHCP automatically gives:

* local IP
* subnet mask
* default gateway
* DNS server

---

# example

Your computer receives:

| Setting        | Example      |
| -------------- | ------------ |
| IP             | 192.168.1.20 |
| Router/Gateway | 192.168.1.1  |
| DNS            | 8.8.8.8      |

---

# packet forwarding process

## Step 1

Browser wants:

```text id="internet025"
google.com
```

---

# Step 2

DNS lookup gets:

```text id="internet026"
Google IP
```

---

# Step 3

Computer creates packets:

* source IP = your IP
* destination IP = Google IP

---

# Step 4

Computer sends packet:

```text id="internet027"
to home router
```

because:

```text id="internet028"
Google outside local network
```

---

# Step 5

Home router forwards packet:

* to ISP router

---

# Step 6

ISP routers forward packet:

* through internet infrastructure

---

# Step 7

Eventually packet reaches:

```text id="internet029"
Google server
```

---

# response path

Google then sends response packets:

* back through internet
* back to your router
* back to your computer

---

# important networking insight

Communication is:

```text id="internet030"
bidirectional packet exchange
```

not:

```text id="internet031"
continuous magical stream
```

---

# analogy

Think of internet packets like:

```text id="internet032"
postal mail
```

Each packet:

* has destination address
* forwarded through sorting centers
* reaches destination eventually

Routers act like:

```text id="internet033"
mail sorting centers
```

---

# why packets are useful

Packets allow:

* multiple communications simultaneously
* rerouting around failures
* efficient bandwidth sharing
* scalable global networking

---

# important protocol layers involved

Several protocols cooperate:

| Layer       | Example       |
| ----------- | ------------- |
| Application | HTTP          |
| Transport   | TCP/UDP       |
| Network     | IP            |
| Link        | Ethernet/WiFi |

You will gradually learn these.

---

# important future connection

Many Linux networking commands you will learn:

* ping
* traceroute
* ip
* ss
* tcpdump

are essentially:

```text id="internet034"
tools for observing packet movement
```

through the network.

---

# excellent conceptual progress

This chapter is VERY important because:

```text id="internet035"
networking is the foundation of modern backend systems
```

Your future work:

* APIs
* Docker
* Kubernetes
* cloud infrastructure
* MQTT
* WebSockets
* AWS

all rely heavily on these exact networking concepts.
