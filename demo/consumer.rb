#!/usr/bin/env ruby

require 'bunny'
require 'json'

connection = Bunny.new(automatically_recover: false)
connection.start

channel  = connection.create_channel
exchange = channel.fanout("spider-default")
queue    = channel.queue("", exclusive: true)
queue.bind(exchange)

puts ' [*] Waiting for logs. To exit press CTRL+C'

begin
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    # puts " [x] #{body}"
    puts JSON.parse(body)
  end
rescue Interrupt => _
  channel.close
  connection.close
end
