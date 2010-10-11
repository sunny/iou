# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
Rails.application.config.secret_token = ENV['IOU_TOKEN'] || '3a50146ad66f8fe08008201a4d76a66a2306221cbb9f547793ef664d80059ff948c55525c3501f9becf3d11ae69653b3eec5053f35b211c27f3b0d7a1f0c53e0b'

