require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/index' do #homepage index request
    erb :index
  end

  get '/signup' do #signup page request
    erb :signup
  end

  post '/signup' do #signup
    user = User.create(:username => params[:username], :password => params[:password])
  end

end
