# This file is used by Rack-based servers to start the application.
#fix for passenger environment
ENV['RAILS_ENV'] = ENV['RACK_ENV']  if !ENV['RAILS_ENV'] && ENV['RACK_ENV'] 

require ::File.expand_path('../config/environment',  __FILE__)
run Challengesplatform::Application
