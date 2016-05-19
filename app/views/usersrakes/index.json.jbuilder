json.array!(@usersrakes) do |usersrake|
  json.extract! usersrake, :id, :routes
  json.url usersrake_url(usersrake, format: :json)
end
