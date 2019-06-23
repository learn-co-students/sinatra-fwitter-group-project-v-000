require './config/environment'
require './app/helpers/helpers.rb'
class ApplicationController < Sinatra::Base

  extend Helpers

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

end