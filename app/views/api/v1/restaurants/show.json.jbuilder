json.extract! @restaurant, :id, :name, :address
json.owner_email @restaurant.user.email
json.comments @restaurant.comments do |comment|
  json.extract! comment, :id, :content
end
