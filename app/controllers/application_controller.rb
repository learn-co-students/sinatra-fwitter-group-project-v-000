require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "Fwitter is secure"
  end

  get '/' do
    erb :index
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] == nil || params[:content] == ""
      redirect to '/tweets/new'
    else
      @tweet = current_user.tweets.create(content: params[:content])
      redirect to '/tweets/#{@tweet.id}'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == "" || params[:content] == nil
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end



  get '/signup' do
    erb :'/users/create_user'
  end
  post '/signup' do
    if is_logged_in?
      redirect '/tweets'
    else
      if !params[:username].empty? && !params[:email].empty? && !params[:password_digest].empty?
        @user = User.create(:username=> params[:username], :email => params[:email], :password_digest => params[:password_digest])
        redirect '/tweets'
      else
        redirect '/signup'
      end
    end
  end

  helpers do

    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
