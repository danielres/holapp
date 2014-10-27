json.array!(@items) do |item|
  json.extract! item, :id, :summary, :body, :language, :created_at, :updated_at
  if item.author
    json.author item.author.name
    json.author_path person_path(item.author)
  end
end
