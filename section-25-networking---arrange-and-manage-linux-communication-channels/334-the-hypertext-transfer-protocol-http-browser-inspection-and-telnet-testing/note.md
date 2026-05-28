## 334. The Hypertext Transfer Protocol (HTTP): Browser Inspection and Telnet Testing

# The HTTP Protocol

## What Is HTTP?

### Definition

* HTTP stands for:

```text id="3x2k8k"
Hypertext Transfer Protocol
```

* HTTP is an application-layer protocol used for communication between:

  * Web browsers
  * Web servers
  * APIs
  * Backend services

---

## HTTP Communication

### Basic Workflow

```text id="fqjlwm"
Browser → HTTP Request → Server
Browser ← HTTP Response ← Server
```

---

## Common HTTP Methods

| Method | Purpose       |
| ------ | ------------- |
| GET    | Retrieve data |
| POST   | Send data     |
| PUT    | Update data   |
| DELETE | Remove data   |

---

# Browser Inspection

## Inspecting HTTP Traffic

Modern browsers allow inspection of network communication.

---

## Opening Developer Tools

### In Chrome or Chromium-Based Browsers

#### Steps

1. Open the browser
2. Right-click anywhere on the page
3. Click:

```text id="jlwm71"
Inspect
```

4. Open the:

```text id="tjlwm7"
Network
```

tab

---

## Capturing HTTP Requests

### Refresh the Page

After refreshing:

* The browser displays all network requests and responses.

---

## Information Visible in the Network Tab

You can inspect:

* HTTP requests
* HTTP responses
* Request headers
* Response headers
* Cookies
* Status codes
* API calls
* File sizes
* Request timing

---

## Example

When opening:

```text id="jlwm88"
https://google.com
```

the browser may send:

* HTML requests
* CSS requests
* JavaScript requests
* Image requests
* API requests

---

# HTTP and TCP

## Important Networking Concept

### HTTP Runs on Top of TCP

Typical stack:

```text id="v8jlwm"
HTTP
↓
TCP
↓
IP
↓
Ethernet / WiFi
```

---

## Packet Segmentation

### Important Observation

* Large HTTP messages are usually split into multiple TCP packets.

Example:

* A large HTML page may be transmitted across many TCP segments.

This process is handled automatically by TCP.

---

# Telnet

## What Is Telnet?

### Definition

* Telnet is a simple program that allows manual TCP connections to remote servers.

---

## Common Uses

### Testing Network Connectivity

Example:

```bash id="jlwm04"
telnet google.com 80
```

---

### Manual Protocol Testing

Telnet allows:

* Sending raw protocol commands manually
* Observing server behavior
* Testing invalid or unexpected requests

---

## Important Note

### Telnet Is Not Secure

* Telnet traffic is unencrypted.
* It should not be used for sensitive communication.

Today:

* SSH replaced Telnet for remote administration.

However:

* Telnet remains useful for protocol testing.

---

# Creating a Manual HTTP Connection

## Step 1: Open a TCP Connection

```bash id="7jlwm1"
telnet google.com 80
```

### Explanation

* `google.com` → destination server
* `80` → HTTP port

---

## Expected Result

```text id="jlwm16"
Connected to google.com
```

At this point:

* Everything typed is sent directly to the remote server.

---

# Sending a Manual HTTP Request

## Example HTTP Request

```text id="jlwm21"
GET / HTTP/1.1
Host: google.com
```

---

## Important HTTP Formatting Rule

After typing the headers:

* Press `ENTER` twice.

Why?

* HTTP headers end with an empty line.

---

## Full Example

```text id="jlwm29"
GET / HTTP/1.1
Host: google.com

```

The final empty line is extremely important.

---

# Server Response

## Example Response

```text id="jlwm36"
HTTP/1.1 200 OK
Content-Type: text/html
...
```

Then the server sends:

* HTML content
* Headers
* Cookies
* Additional metadata

---

# Understanding the HTTP Request

## Request Line

```text id="jlwm44"
GET / HTTP/1.1
```

### Meaning

| Part     | Description      |
| -------- | ---------------- |
| GET      | HTTP method      |
| /        | Requested path   |
| HTTP/1.1 | Protocol version |

---

## Host Header

```text id="jlwm52"
Host: google.com
```

### Why It Is Important

* Modern web servers host multiple websites on the same IP address.
* The `Host` header tells the server which website is requested.

Without the `Host` header:

* HTTP/1.1 requests may fail.

---

# HTTP Response Structure

## Example

```text id="jlwm60"
HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 1234

<html>...</html>
```

---

## Response Components

| Component   | Purpose                     |
| ----------- | --------------------------- |
| Status line | Response status             |
| Headers     | Metadata                    |
| Empty line  | Separates headers from body |
| Body        | Actual content              |

---

# Common HTTP Status Codes

| Code | Meaning               |
| ---- | --------------------- |
| 200  | OK                    |
| 301  | Redirect              |
| 400  | Bad Request           |
| 401  | Unauthorized          |
| 403  | Forbidden             |
| 404  | Not Found             |
| 500  | Internal Server Error |

---

# Practical Examples

## Request a Specific Page

```text id="jlwm68"
GET /search HTTP/1.1
Host: google.com

```

---

## Trigger an Invalid Request

```text id="jlwm76"
HELLO SERVER
```

Useful for:

* Observing server error handling
* Protocol debugging
* Understanding HTTP parsing

---

# Real-World Backend Relevance

Understanding raw HTTP is extremely important for:

* Backend development
* REST APIs
* Reverse proxies
* Nginx
* Load balancers
* API gateways
* WebSocket upgrades
* Debugging production systems

---

# Relationship to APIs

When a frontend application calls:

```text id="jlwm84"
https://api.example.com/users
```

it is fundamentally sending:

* HTTP requests
* TCP packets

exactly like the Telnet examples above.

Frameworks such as:

* Spring Boot
* Express.js
* Django

all ultimately communicate using HTTP.

---

# Important Limitation of Telnet

## HTTPS Does Not Work Properly with Telnet

### Why?

* HTTPS requires TLS encryption before HTTP communication begins.
* Telnet only opens raw TCP connections.

For HTTPS testing, tools such as:

* `openssl s_client`
* `curl`
* `wget`

are preferred.

---

# Alternative Modern Tools

| Tool             | Purpose                 |
| ---------------- | ----------------------- |
| telnet           | Raw TCP testing         |
| curl             | HTTP requests           |
| wget             | Downloading files       |
| openssl s_client | TLS inspection          |
| nc (netcat)      | General TCP/UDP testing |

---

# Practical Labs

## Test HTTP

```bash id="jlwm92"
telnet example.com 80
```

Then send:

```text id="jlwm97"
GET / HTTP/1.1
Host: example.com

```

---

## Observe Browser Requests

1. Open Chrome
2. Open Developer Tools
3. Go to Network tab
4. Refresh the page
5. Inspect requests and responses

---

# Important Networking Concept

### Browser Abstraction

Browsers hide protocol complexity.

However internally:

* Websites are simply:

  * HTTP messages
  * TCP packets
  * IP communication

Understanding these lower layers is extremely important for advanced backend and DevOps work.
