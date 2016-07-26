json.array!(@courses) do |course|
  json.extract! course, :id, :name, :minutes, :description
  json.url course_url(course, format: :json)
end
