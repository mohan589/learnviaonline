json.array!(@profiles) do |profile|
  json.extract! profile, :id, :name, :age, :email, :mobile, :photo
  json.url profile_url(profile, format: :json)
end
