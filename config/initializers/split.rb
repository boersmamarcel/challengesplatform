Split::Dashboard.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == 'p4s5w0rd'
end