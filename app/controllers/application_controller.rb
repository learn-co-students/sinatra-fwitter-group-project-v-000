require './config/environment'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'WPxNoD1%Ww4PDbA5cUR^kSxF1'
  end

  get '/' do
    erb :index
  end

end
