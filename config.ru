require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

require_relative 'app/controllers/tweets_controller'

use Rack::MethodOverride
use TweetsController
run ApplicationController
