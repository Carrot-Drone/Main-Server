json.array!(@flyers) do |flyer|
  json.extract! flyer, :id
  json.url flyer_url(flyer, format: :json)
end
