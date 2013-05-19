Dir[Rails.root + 'app/exceptions/*.rb'].each do |file|
  require file
end