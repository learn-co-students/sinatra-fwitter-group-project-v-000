require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use UserController
use TweetController #you can initialize multiple controllers using 'use'
run ApplicationController #you can run 1 controller
