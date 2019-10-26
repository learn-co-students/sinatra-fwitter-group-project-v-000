# tell Rack here's the controller to use
require './config/environment'

#
if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# a Rack module for handling browser-unsupported HTTP verbs in web applications
use Rack::MethodOverride
#use Rack::Session::Pool

#
use TweetsController
use UsersController
#
run ApplicationController
