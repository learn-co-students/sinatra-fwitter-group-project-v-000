require './config/environment'
require_relative 'app/controllers/users_controller'
require_relative 'app/controllers/tweets_controller'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use TweetsController
use UsersController
use Rack::MethodOverride
run ApplicationController