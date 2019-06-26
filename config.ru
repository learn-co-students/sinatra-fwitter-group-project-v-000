require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
run ApplicationController

# defer the '/signup' logic from ApplicationContoller
# to the logic set in the contollers below
use UsersController
use TweetsController