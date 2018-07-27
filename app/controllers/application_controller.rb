require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'secret'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/tweets'
    end  
  end

  post '/signup' do
    if params.values.any? { |val| val == "" }
        redirect '/signup'
    else
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect '/tweets'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect '/login'
      end  
  end

  get '/logout' do 
    if session[:user_id] != nil
      session.destroy
      redirect '/login'
    else
      redirect '/tweets'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params.values.any? { |val| val == "" }
        redirect '/tweets/new'
      else
        @user = current_user
        @tweet = Tweet.create(:id => params[:id], :content => params[:content], :user_id => session[:user_id])
        puts params
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else 
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit_tweet'
      else
          redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @user = current_user
      if params[:content] == ""
        @tweet = Tweet.find(params[:id])
        redirect to "/tweets/#{@tweet.id}/edit"
      else
        @tweet = Tweet.find(params[:id])
        if @tweet && @tweet.user == current_user
          if @tweet.update(:content => params[:content])
            redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect '/tweets'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.destroy
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/failure' do
      erb :error
  end


  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end
  end


end
