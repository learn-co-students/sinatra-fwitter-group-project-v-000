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
    erb :signup
  end

  post '/signup' do

    invalid = 0
    params.each do |param|
      invalid = 1 if param[1] == ""
    end
    redirect '/signup' if invalid == 1

    @user = User.create(params)
    session[:user_id] = @user.id
    redirect '/tweets'
  end

end
