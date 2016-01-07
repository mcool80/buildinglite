json.array!(@apartments) do |apartment|
  json.extract! apartment, :id, :address, :apartment_no
  json.url apartment_url(apartment, format: :json)
end
