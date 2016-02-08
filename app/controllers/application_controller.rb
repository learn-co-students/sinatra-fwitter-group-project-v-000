require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id].nil?
      erb :signup
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    params.any? {|k,v| v.blank?} ? redirect('/signup') : user = User.create(params)
    session[:user_id] = user.id
    redirect '/tweets'
  end

  get '/tweets' do
    erb :'tweets/index'
  end

end
