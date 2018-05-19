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
    erb :'/users/create_user'
  end

  post '/signup' do
    #sign in user using params
    #add user_id to sessions hash
    #does not allow signup without username/email/password -> redirect again to signup
    redirect to '/tweets/tweets'
  end

  get '/tweets/tweets' do
    erb :'/tweets/tweets'
  end

end
