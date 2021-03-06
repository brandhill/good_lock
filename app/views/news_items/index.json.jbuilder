json.array!(@news_items) do |news_item|
  json.extract! news_item, :id, :type, :title, :description, :image_url, :link, :publish_at, :raw_data
  json.url news_item_url(news_item, format: :json)
  json.stripped_title strip_tags(news_item.title)
  json.stripped_description strip_tags(news_item.description)
end
