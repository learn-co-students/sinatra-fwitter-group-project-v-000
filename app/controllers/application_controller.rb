require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'users/create_user'
  end

  post '/signup' do

    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      user = User.new(params)
    else
      redirect to '/signup'
    end
    if user.save
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/tweets' do
    @tweets = Tweet.all

  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.create(params)
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    binding.pry
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  end




  helpers do
      def logged_in?
        !!session[:user_id]
      end

      def current_user
        User.find(session[:user_id])
      end
    end
end
