json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :title, :video, :minutes
  json.url lesson_url(lesson, format: :json)
end
