# Populate the graph with some random points

require 'open-uri'

#json_object = JSON.parse((URI.parse("http://ec2-54-83-155-47.compute-1.amazonaws.com:5000/api/v1/mentions?function=count").read))

points = []
(1..10).each do |i|
  points << { x: i, y: rand(50) }
end
last_x = points.last[:x]

SCHEDULER.every '2s' do
  points.shift
  last_x += 1
  points << { x: last_x, y: rand(50) }

  send_event('convergence', points: points)
end