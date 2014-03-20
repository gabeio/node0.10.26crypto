#import the crypto library
argv = require 'optimist'
  .argv
crypto = require 'crypto'

crypto.DEFAULT_ENCODING = 'base64'

if argv.pass
  if argv.encryption
    encryption = argv.encryption
  else
    encryption = "aes-256-cbc"
  if !argv.encrypt and !argv.decrypt
    console.log 'use --encrypt or --decrypt'
    .exit
  if !argv.bytes
    console.log 'we need something to encrypt or decrypt, use --bytes <whatever here>'
    .exit
  en = crypto.createCipher(encryption,argv.pass)
  de = crypto.createDecipher(encryption,argv.pass)
  encrypted = ""
  decrypted = ""
  if argv.encrypt and argv.bytes
    encrypted += en.update(argv.bytes,'utf8','base64')
    encrypted += en.final('base64')
    console.log encrypted
  if argv.decrypt and argv.bytes
    de.on('error',(e)->
      console.error 'looks like you have the wrong key.'
    )
    decrypted += de.update(argv.bytes,'base64','utf8')
    decrypted += de.final('utf8')
    console.log decrypted
else
  console.log '--pass <password> required'