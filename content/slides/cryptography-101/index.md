---
title: Cryptography 101
summary: Basic Crypto
authors: [ "admin" ]
tags: [ "Cryptography", "Slide"] 
categories: ["Cryptography"]
date: "2019-05-22:00:00Z"
slides:
  theme: black
  highlight_style: dracula
---
# Cryptography 101

---
## What is cryptography

-   The art of writing or solving codes.
-   Comes from the greek kryptos-graphein meaning hidden writing
-   The only mathematically sound security measure


---
## Brief history


## Cesar Cipher

-   Used by Cesar for personal communication in the 1st Century BCE
-   Simple substitution cipher
-   Can be easily cracked based on character frequency


## Enigma

-   Used by Nazi Germany during WWII
-   Complex substitution cipher
-   Fatal flaw that no letter could be itself
-   Cracked by Alan Turing and his Team from the UK


## The big change

-   Up until this point all ciphers where symmetric
-   Means the same key is used to encrypt and decrypt
-   How to share the key securely?


## RSA

-   The first asymmetric cipher
-   Developed in 1977
-   Has two keys instead of one


---
## Asymmetric Cryptography


## How does this work

-   Relies on one way math functions
-   Some mathematical functions are east to do one way, but hard to reverse
-   These are:
    -   Multiplying primes
    -   Modulus
    -   Elliptic Curves


### Primes

-   Multiplying two primes
    
    \begin{equation}
    7 \times 13 = 91 \text{(Easy)}
    \end{equation}
-   Factoring a product of two primes
    
    \begin{equation}
    a \times b = 68 \text{(Hard)}
    \end{equation}


### Modulus

-   Modulus is the remainder
-   Like a clock
    
    \begin{equation}
    13 \mod 12 = 1
    \end{equation}
    
    \begin{equation}
    16 \mod 12 = 4
    \end{equation}
-   Doing reverse is hard
    
    \begin{equation}
    a \mod 10 = 5
    \end{equation}
-   what is a?
-   5, 15, 25, 55, 105, or 900000005?


### Elliptic Curves

-   Way out of the scope of this talk
-   Basically using curve functions to calculate data
-   Think parabolas and such


## RSA

-   Relies on Primes and Modulus
-   Private and public keys
-   Keys are just prime numbers
-   You can encrypt with public or private
-   Whatever key you do an operation with, you will need the opposite key to
    reverse it
-   If you encrypt with private, you can only decrypt with public


### Example

1.  Choose two distinct prime numbers
    
    \begin{equation}
    p=61
    \\
    q=51
    \end{equation}
2.  Compute n = pq
    
    \begin{equation}
    n = 61 \times 53 = 3233
    \end{equation}
3.  Compute the Carmichael's totient function of the product as λ(n) = lcm(p − 1, q − 1)
    
    \begin{equation}
    \lambda(n) = \text{lcm}(60, 52) = 780
    \end{equation}
    
    {{< speaker_note >}}
    -   Sounds complex
    -   Gives us an exponent so that any coprime of n when given that a<sup>m</sup> mod n = 1
        where a is the coprime
    -   What's a coprime? Two integers that the only common divisor is 1
    -   We can calculate totient using LCM (least common multiple)
    
    {{< /speaker_note >}}
4.  Choose any number 1 < e < 780 that is coprime to 780. Choosing a prime number for e leaves us only to check that e is not a divisor of 780.
    
    \begin{equation}
    e = 17
    \end{equation}
5.  Compute d, the modular multiplicative inverse of e (mod λ(n))
    
    \begin{equation}
    d \times e \mod \lambda(n) = 1
    \\
    413 \times 17 \mod 780 = 1
    \end{equation}

{{< speaker_note >}}
-   Modular multiplicative inverse means d\*e is congruent to 1 (mod λ(n))

{{< /speaker_note >}}

1.  public key is (n = 3233, e = 17), with message m, encryption function is
    
    \begin{equation}
    c(m) = m^{17} \mod 3233
    \\
    c = 65^{17} \mod 3233 = 2790
    \end{equation}
2.  private key is (n = 3233, d = 413), with ciphertext c, decryption function is
    
    \begin{equation}
    m(c) = c^{413} \mod 3233
    \\
    m = 2790^{413} \mod 3233 = 65
    \end{equation}


### Where is RSA used

-   HTTPS
-   SSH
-   any TLS or SSL implementation
-   Email
-   PGP


---
## Key Exchanges

-   RSA is all well and good
-   But how do you securely exchange keys
-   This is where the Diffie–Hellman key exchange comes into play


## Diffie-Hellman

-   An algorithm for securely transferring keys publicly
-   Simple in design, yet surprisingly robust


## Simple overview


### Generating Initial Secrets

![img](talks.org_imgs/Crypto/diffie-helman-part1.png)


### Derriving Shared Secrets

![img](talks.org_imgs/Crypto/diffie-helman-part2.png)


---
## Hashes

-   Hashes are unpredictable, random, digests of data.
-   They have a few key features:
    -   Random, and completely unpredictable
    -   One way, they cannot be easily reversed
    -   Transform large data into small data of a known size
    -   Unique, not likely that two pieces of data with the same hash


## Random

-   Hashes should be sufficiently random
-   They should be virtually impossible to predict


## One way

-   Hashes should be impossible to reverse
-   The only way to find the original data is to brute force


## Transform

-   Hashes should be able to represent larger data
-   They should be a known length


## Unique

-   Hashes are flawed
-   Converting large data to small data will result in clashes
-   These are called collisions
-   A good hash should reduce the likely-hood of collisions


## Uses of hashes

-   What's the use-case?
    -   Data/File verification
    -   Storing passwords securely
    -   Digital signing


## Caveats

-   Not all hash algorithms are created equal
-   Use different ones for your use case
-   Storing passwords? Use CPU insensitive algorithms (BCrypt)
-   There's more, but that's for another talk


---
## The hidden complexity

-   The maths behind cryptography is fairly straightforward
-   The maths is also very secure
-   The implementation may not be


## Unsafe implementation

-   It's easy to implement RSA or AES yourself
-   It's easy to miss hidden complexities
-   It's hard to generate sufficiently random numbers
-   It's hard to avoid leaking information about the key


---
## Takeaways

-   Do not implement your own crypto
-   Do not implement an existing crypto
-   Use an existing implementation that's been proven to work
-   Use Libsodium
-   Even if you do everything right it's pointless since the AABill passed

