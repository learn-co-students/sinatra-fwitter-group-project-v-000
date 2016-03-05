require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "whatevs"
  end

  get '/' do
    erb :index
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
  # binding.pry

    @user=User.find_by(email: params["user"]["email"])
    if @user && @user.authenticate(params["user"]["password"])
      session[:user_id]=@user[:id]
      redirect '/tweets'
    else
      erb :failure
    end
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do

    if taken?
      erb :failure, :locals => {:message => "Someone already signed up with that email address."}
    else
      @user=User.new(params["user"])
      if @user.save
        session[:user_id]=@user[:id]
        redirect '/tweets'
      else
        redirect '/failure'
      end
    end

  end


  get '/tweets' do
    if is_logged_in
      @user=current_user
      erb :'tweets/tweets'
    else
      erb :failure, :locals=>{:message=>"You must be logged in to do that."}
    end
  end

  get '/tweets/new' do
    if is_logged_in
      @user=current_user
      erb :'tweets/create_tweet'
    else
      erb :failure, :locals=>{:message=>"You must be logged in to do that."}
    end
  end

  post '/tweets' do
    
    if session[:user_id]=params["user"]["id"]
      @tweet=Tweet.new(content: params["user"]["tweet"])
      @tweet.user_id=session[:user_id]
      @tweet.save
      erb :'tweets/show_tweet'
    else
      erb :failure, :locals=>{:message => "You must be logged in to do that"}
    end
  end

  get '/tweets/:id' do
    @tweet=Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet=Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  post '/tweets/:id' do

binding.pry
    @tweet.save
  end

  get '/tweets/:id/delete' do
binding.pry
    @tweet=Tweet.find(params[:id])
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


  get '/home' do
    if is_logged_in
      @user=current_user
      erb :index
    else
      redirect '/'
    end
  end

  helpers do 
          def current_user
            User.find(session[:user_id])
          end

          def is_logged_in
            !!session[:user_id]
          end

          def taken?
            !User.where(params["user"]["email"]).empty?
          end
  end
end