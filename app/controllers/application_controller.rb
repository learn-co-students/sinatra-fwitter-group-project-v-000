require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    @user = User.new(username: params[:username],
                     email: params[:email],
                     password_digest: params[:password]
                  )
    @user.save

    erb :'tweets/tweets'
  end

end
