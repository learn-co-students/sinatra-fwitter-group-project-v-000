require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  use Rack::Flash
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :session_secret, "my_application_secret"
  # set :views, Proc.new { File.join(root, "../views/") }

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    if session[:user_id]
      redirect to '/tweets'
    else
      erb :index
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/signup' do
    if session[:user_id]
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  get '/login' do
    if session[:user_id]
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  get '/tweets' do
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      username = @user.username
      @allTweets = Tweet.all.to_a
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id].blank?
      redirect to '/login'
    end
    @tweet = Tweet.find_by(id: params[:id])
    if ((@tweet.nil?) || (@tweet.user_id != session[:user_id]))
      redirect to '/tweets'
    end
    @patchLink = '/tweets/' + params[:id].to_s + '/edit'
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id/edit' do
    puts 'patch action!! /n'
    if params[:content].blank?  #check if tweet is blank
      flash[:message] = 'Tweet cannot be blank.'
      redirectLink = '/tweets/' + params[:id].to_s + '/edit'
      redirect to redirectLink
    end
    if session[:user_id].blank? #check if user logged in - this should never fail, but safety
      redirect to '/login'
    end
    @tweet = Tweet.find_by(id: params[:id])
    if ((@tweet.nil?) || (@tweet.user_id != session[:user_id])) #check if tweet doesn't exist or doesn't belong to user
      redirect to '/tweets'
    end
    @tweet.update(content: params[:content])
    redirectLink = '/tweets/' + @tweet.id.to_s
    redirect to redirectLink
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.nil?
      redirect to '/error'
    end
    if ((session[:user_id].blank? == false) && (session[:user_id] == @tweet.user_id))
      Tweet.delete(@tweet.id)
      redirect to '/'
    else
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.nil?
      redirect to '/error'
    elsif session[:user_id].blank?
      redirect to '/login'
    # elsif (session[:user_id] != @tweet.user_id)
    #   redirect to '/error'
    else
      @user = User.find_by(id: @tweet.user_id)
      @delete_link = '/tweets/' + params[:id] + '/delete'
      @edit_link = '/tweets/' + params[:id] + '/edit'
      erb :'tweets/show_tweet'
    end
  end

  get '/error' do
    erb :error
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      flash[:message] = "You have been logged out."
      redirect to '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @userTweets = []
    @user.tweets.each do |tweet|
      @userTweets << tweets
    end
    erb :'users/show'
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/tweets'
    else
        redirect to '/error'
    end
  end

  post '/signup' do
    puts params[:username]
    puts params[:password]
    puts params[:email]
    if (params[:username].blank?)
      flash[:message] = "Username cannot be blank."
      redirect to '/signup'
    elsif (params[:password].blank?)
      flash[:message] = "Password cannot be blank."
      redirect to '/signup'
    elsif (params[:email].blank?)
      flash[:message] = "Email cannot be blank."
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  post '/tweets/new' do
    if params[:content].blank?
      flash[:message] = "Tweet content cannot be blank."
      redirect to '/tweets/new'
    else
      # puts 'Hit post action'
      @user = User.find_by(id: session[:user_id])
      # puts 'Logged in user is ' + @user.username + ' with id ' + @user.id.to_s
      # puts 'Parameter content is ' + params[:content]
      @tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
      # puts @tweet.content
      redirect to '/tweets'
    end
  end

end
