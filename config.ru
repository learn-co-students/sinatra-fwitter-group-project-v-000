require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

require_relative 'app/controllers/tweets_controller'
require_relative 'app/controllers/users_controller'

use UsersController
use TweetsController

use Rack::MethodOverride
run ApplicationController