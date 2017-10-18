require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :sessions, 'fwitter'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/new'
  end

  post '/signup' do
    if params["username"] != "" && params["email"] != "" && params["password"] != ""
    @user = User.new(username: params['username'], email: params['email'], password: params['password'])
    @user.save
    session[:user_id] = @user.id
    binding.pry
    redirect '/tweets'
    else
    redirect '/signup'
    end
  end

end
