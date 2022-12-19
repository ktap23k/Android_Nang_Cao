import base64
import hashlib
from Crypto import Random
from Crypto.Cipher import AES

class AESCipher(object):

    def __init__(self, key): 
        self.bs = AES.block_size
        self.key = hashlib.sha256(key.encode()).digest()

    def encrypt(self, raw):
        raw = self.pad(raw)
        # iv = Random.new().read(AES.block_size)
        iv = base64.b64decode('iKD1vVYLq760rnZ1RqFXfg==')
        cipher = AES.new(self.key, AES.MODE_CBC, iv)
        data = cipher.encrypt(raw)
        return base64.b64encode(data)

    def decrypt(self, enc):
        enc = base64.b64decode(enc)
        iv = base64.b64decode('iKD1vVYLq760rnZ1RqFXfg==')
        cipher = AES.new(self.key, AES.MODE_CBC, iv)
        return self.unpad(cipher.decrypt(enc))

    def pad(self, s):
        padsize = self.bs - len(s.encode('utf-8')) % self.bs
        return (s + padsize * chr(padsize)).encode('utf-8')

    def unpad(self, s):
        s = s.decode('utf-8')
        offset = ord(s[-1])
        return s[:-offset]

ed = AESCipher(key='my 32 length key...............,')

data = ed.encrypt('{"key":"trần anh tuấn"}')
print(data.decode('utf-8'))

data = ed.decrypt(data.decode('utf-8'))
print(data)