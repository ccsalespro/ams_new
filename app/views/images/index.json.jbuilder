json.array!(@images) do |image|
  json.extract! image, :id, :filename, :content_type, :file_contents
  json.url image_url(image, format: :json)
end
