require './config/environment'

require './app/controllers/user_controller.rb'
require './app/controllers/tweet_controller.rb'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use UserController
use TweetController

run ApplicationController
