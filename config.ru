require './config/environment'
require 'require_all'
require_all 'app'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use TweetsController
use UsersController
run ApplicationController
