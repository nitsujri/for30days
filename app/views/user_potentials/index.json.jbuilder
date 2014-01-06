json.array!(@user_potentials) do |user_potential|
  json.extract! user_potential, :id, :email
  json.url user_potential_url(user_potential, format: :json)
end
