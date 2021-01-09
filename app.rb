require 'dotenv/load'
require 'nature_remo_e'
require 'ruby-ambient'

client = NatureRemoE::Client.new(ENV['NATURE_REMO_API_TOKEN'])

ambient = Ambient.new(ENV['AMBIENT_CHANNEL_ID'], write_key: ENV['AMBIENT_WRITE_KEY'])
ambient.send({ d1: client.measured_instantaneous })
