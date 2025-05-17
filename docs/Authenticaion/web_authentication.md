---
marp: true
---

<style>
h1 {
  font-size: 3em;
  font-family: 'Arial', sans-serif;
}

h2 {
  font-size: 2.5em;
  font-family: 'Arial', sans-serif;
}

p {
  font-size: 1.5em;
  font-family: 'Arial', sans-serif;
}
</style>

# WEB AUTHENTICATION

---

## Type of authentication
Single Sign-On (SSO)
Multi-Factor Authentication (MFA)
Passwordless
WebAuthn

---

## Password-based
![w:1200 h:450](security_spectrum.png)

---

## COOKIES & JWT
![alt text](cookies_based.png)
Works with sessions. State lives on the server

---

![alt text](jwt_based.png)
Works with signed tokens. State is on the client

---

## References
[1] Web Authentication Methods Explained. https://youtu.be/LB_lBMWH4-s?si=uwXj5S6QUwpQYdXq
[2] HTTP Cookie. https://en.wikipedia.org/wiki/HTTP_cookie
[3] Introduction to JSON Web Tokens. https://jwt.io/introduction