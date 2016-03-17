require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "super_application_secret"
  end

  get "/" do 
    erb :index
  end

  get "/signup" do 
    if logged_in?
      redirect to "/tweets"
    end
    erb :"/users/create_user"
  end

  post "/signup" do 
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id # log in the user after they sign up
      redirect to "/tweets"
    end
  end

    get '/login' do 
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    #raise params.inspect
    @user = User.find_by(:username => params["username"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect to '/login' #or login?
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/login"
    end
  end
########################### tweets ###########################
  get "/tweets" do 
    #@user = current_user
    @tweets = Tweet.all
    if logged_in?
      @user = current_user
      erb :"/tweets/tweets"
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do 
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
  #raise params.inspect 
    if params[:tweet][:content] == ""
      redirect '/tweets/new'
    else
      @user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(:content => params[:tweet][:content], :user_id => session[:user_id])
    redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    #raise params.inspect
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])      
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end 
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == @user.id  #you can edit tweet if its yours
        erb :'/tweets/edit_tweet'
      else #cant edit
        redirect "/tweets/tweets" #{@tweet.id}
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do 
    #raise params.inspect
    @tweet = Tweet.find_by_id(params[:id])
    if params[:tweet][:content] != ""
      @tweet.content = params[:tweet][:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}" 
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == @user.id  #you can edit tweet if its yours
        @tweet.delete
        redirect "/tweets"
      else 
        redirect "/tweets/#{@tweet.id}" 
      end
    else
      redirect '/login'
    end
  end

########################### users ###########################
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

########################### helpers ###########################

  helpers do
    def logged_in?
      !!session[:user_id]
    end
  
    def current_user
      User.find(session[:user_id])
    end
  end




end