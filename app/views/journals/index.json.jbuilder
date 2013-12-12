json.array!(@journals) do |journal|
  json.extract! journal, :id
  json.url journal_url(journal, format: :json)
end
