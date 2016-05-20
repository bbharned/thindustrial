json.array!(@courses) do |course|
  json.extract! course, :id, :title, :description, :timeblock
  json.url course_url(course, format: :json)
end
