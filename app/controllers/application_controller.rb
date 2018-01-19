require './config/environment'
class ApplicationController < Sinatra::Base
  helpers ApplicationHelpers

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "password_security"
    set :show_exceptions, false unless ENV['SINATRA_ENV'] == 'development'
  end

  set :views, Proc.new { File.join(root, "../views") }

  get '/' do
    erb :index
  end
  
  before '/tweets*' do
    redirect '/login' unless current_user
  end

  before /\/(signup|login)/ do
    redirect '/tweets' if current_user
  end
end