require './config/environment'

class ApplicationController < Sinatra::Base
  include Helpers
  configure do
    enable :sessions unless test?
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'application/index'
  end

end
