json.array!(@chapters) do |chapter|
  json.extract! chapter, :id, :name, :minutes
  json.url chapter_url(chapter, format: :json)
end
