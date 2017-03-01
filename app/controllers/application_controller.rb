require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "pollywog"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/login'
    end
  end

  post '/login' do
     user = User.find_by(username: params[:username])
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect '/tweets'
     else
       redirect "/signup"
     end
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == '' || params[:email] == '' || params[:password] == ''
      redirect "/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/logout' do
    if !logged_in?
      redirect '/'
    else
      session.clear
      redirect '/login'
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
    erb :'tweets/tweets'
    end
  end

  get '/users/:slug' do
    if !logged_in?
      redirect '/login'
    else
    #  @user = User.find_by_slug(params[:slug])
    #end
    #@user = User.find_by_slug(params[:slug])
    erb :'users/show'
    end
  end


  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'tweets/create_tweet'
    end
  end

  post '/tweets/new' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
    @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
    redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    end
  end

  post '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login"
    elsif params[:content] == ""
      redirect "tweets/#{params[:id]}/edit"
    else
      tweet = Tweet.find(params[:id])
      tweet.content = params[:content]
      tweet.save
      redirect "/tweets/#{tweet.id}"
    end
  end

  get '/tweets/:id/delete' do
    if !logged_in?
      redirect "/login"
    elsif current_user.id != Tweet.find(params[:id]).user_id
      redirect '/tweets'
    else
      Tweet.delete(params[:id])
      redirect '/tweets'
    end
  end

  post '/tweets/:id/delete' do
    redirect "/tweets/#{params[:id]}/delete"
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
