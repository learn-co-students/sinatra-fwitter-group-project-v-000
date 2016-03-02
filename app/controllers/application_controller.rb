require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret , "secret"
  end

  get '/' do
    erb :index
  end

  get '/tweets' do
    #index of all tweets
    if session[:user_id]
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end   
  end

  get '/signup' do
    if !session[:user_id]
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params.any? {|param,value| value == ""}
      redirect to '/signup'
    else
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect to '/tweets'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if session[:user_id] #if logged in
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get "/users/:slug" do
      @user = User.find_by_slug(params[:slug]) 
      erb :'users/show'
    end

  get "/tweets/new" do
    if session[:user_id]
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post "/tweets" do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
    user = User.find_by_id(session[:user_id])
    @tweet = Tweet.create(content: params[:content], user_id: user.id)
    redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  post '/tweets/:id/delete' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
      else
        redirect to '/login'
      end
  end

  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
      erb :'/tweets/edit_tweet'
    else
      redirect to '/tweets'
    end
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id' do
    if params[:content] ==""
      redirect to "/tweets/#{params[:id]}/edit"
    else
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end
  end
end

# user show page
#     shows all a single users tweets (FAILED - 1)
# new action
#     logged in
#       lets user view new tweet form if logged in (FAILED - 2)
#       lets user create a tweet if they are logged in (FAILED - 3)
#       does not let a user tweet from another user (FAILED - 4)
#       does not let a user create a blank tweet (FAILED - 5)
#     logged out
#       does not let user view new tweet form if not logged in (FAILED - 6)
#     show action
#       logged in
#         displays a single tweet (FAILED - 7)
#       logged out
#         does not let a user view a tweet (FAILED - 8)







