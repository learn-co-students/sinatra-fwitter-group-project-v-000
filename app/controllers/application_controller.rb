require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if !params.any?{|k, v| v == "" || v == " " || v == nil}
      @user = User.create(params)
      session[:id] = @user.id
    else
       redirect to '/signup'
    end
      redirect to '/tweets'
  end

  get '/tweets' do

  end

end
