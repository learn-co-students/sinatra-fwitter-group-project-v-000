require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :homepage
  end

  get '/signup' do
    if session[:user_id] != nil
      redirect to '/tweets'
    else
      erb :signup
    end
  end

  post '/signup' do
    params.each do |x, y|
      if y == ''
        redirect to '/signup'
      end
    end
    user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    session[:user_id] = user.id
    redirect to '/tweets'
  end

  get '/login' do
    if session[:user_id] == nil
      erb :login
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    if User.find_by(username: params["username"]) != nil
      @user = User.find_by(username: params["username"])
      session[:user_id] = @user.id
    end
    redirect to '/tweets'
  end

  get '/logout' do
    if session[:user_id] != nil
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/tweets' do
    if session[:user_id] != nil
      erb :tweets
    else
      redirect to '/login'
    end
  end

  get "/users/:name" do
    @user = User.find_by(username: params["name"])
    erb :usertweets
  end

  get "/tweets/new" do
    if session[:user_id] == nil
      redirect to '/login'
    else
      erb :newtweet
    end
  end

  post "/tweets/new" do
    if params["content"] != ""
      @tweet = Tweet.create(content: params["content"])
      @tweet.user_id = session[:user_id]
      @tweet.save
    else
    end
  end

  get "/tweets/:id" do
    if session[:user_id] == nil
      redirect to '/login'
    else
      @tweet = Tweet.find(params["id"])
      erb :tweetinfo
    end
  end

  get "/tweets/:id/edit" do
    if session[:user_id] == nil
      redirect to '/login'
    end
    @tweet = Tweet.find(params["id"])
    erb :edittweet
  end

  patch '/tweets/:id' do
    if params["content"] == ""
      redirect to '/tweets/' + params["id"] + '/edit'
    end
    @tweet = Tweet.find(params["id"])
    @tweet.content = params["content"]
    @tweet.save
  end

  delete '/tweet/:id/delete' do
    @tweet = Tweet.find(params["captures"][0].to_i)
    if session[:user_id] == params["id"].to_i
      Tweet.delete(params["id"])
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end

end
