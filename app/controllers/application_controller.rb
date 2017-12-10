require './config/environment'

class ApplicationController < Sinatra::Base


  enable :sessions
  set :session_secret, "secret"
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :"index"
  end

# SENDS signup form
  get '/registrations/signup' do
    erb :"/registrations/signup"
  end

# POSTS sign up form and CREATES user
  post '/registrations/signup' do
    @user = User.create(name: params[:username], email: params[:email], password: params[:password])
    session[:id] = @user.id
    redirect to erb :"/twitter/index"
  end
end
