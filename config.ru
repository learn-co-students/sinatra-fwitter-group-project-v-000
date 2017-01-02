require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::Static, :urls => ['/css','/fonts','/js','/images'], :root => 'public' # Rack fix allows seeing the static folders.

use Rack::MethodOverride
use TweetsController
use UsersController
run ApplicationController