json.array!(@items) do |item|
  json.author   item.author.try(:name)
  json.summary  item.summary
  json.language item.language
  json.body     item.body
end
