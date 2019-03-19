require './config/environment'
# require_relative 'app/controllers/application_controller'


if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use UsersController
use TweetsController
run ApplicationController
