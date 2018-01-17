require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
#if Tweet and user controllers are made, you need to use them here
#   use TweetController
#   use UserController
run ApplicationController
