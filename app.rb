require 'dotenv/load'
require 'nature_remo'
require 'ruby-ambient'

client = NatureRemo::Client.new(ENV['NATURE_REMO_API_TOKEN'])
response = client.appliances
appliances = JSON.parse(response.body, symbolize_names: true)

el_smart_meter = appliances.find { |appliance| appliance[:type] == 'EL_SMART_METER' }
echonetlite_properties = el_smart_meter[:smart_meter][:echonetlite_properties].each_with_object({}) do |echonetlite_property, hash|
  hash[echonetlite_property[:name].to_sym] = echonetlite_property[:val].to_i
end

ambient = Ambient.new(ENV['AMBIENT_CHANNEL_ID'], write_key: ENV['AMBIENT_WRITE_KEY'])
ambient.send({ d1: echonetlite_properties[:measured_instantaneous] })
