require './config/environment'
# require 'rack-flash'

class ApplicationController < Sinatra::Base
  # use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :"index"
  end

  get '/signup' do
    erb :"/users/create_users"
  end

  post '/signup' do
  if params[:username].empty? || params[:password].empty? || params[:email].empty?
      # flash[:message] = "Please enter all fields."
      redirect '/signup'
    else
    redirect '/tweets'
    end
  end

  get '/tweets' do
    # binding.pry
    @tweets = Tweet.all
    erb :"/tweets/index"
  end

end
