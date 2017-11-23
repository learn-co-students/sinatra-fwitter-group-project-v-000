require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

# I'm putting these in this order so that the not-logged-in catcher
# will override any routes in TweetsController and ApplicationController.
# I haven't tested the other way around, so maybe I'll do that, but this
# makes enough sense as is.
use UsersController
use TweetsController

run ApplicationController
