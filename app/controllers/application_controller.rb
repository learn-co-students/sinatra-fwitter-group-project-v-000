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
  puts params
  # @user = User.(params)
  #
  #

  if params[:username].empty?
    redirect to erb :'/signup'

    elsif params[:email].empty?
      redirect erb :'/signup'

    elsif params[:password].empty?
      redirect erb :'/signup'

    else @user = User.create(params)

    redirect to erb :'tweets/tweets/'
  end
end
end
