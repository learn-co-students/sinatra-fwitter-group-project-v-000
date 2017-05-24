class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "never_trust_the_ide"
  end

  get '/signup' do
    if !session[:user_id]
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params.any? {|k, v| v.length <=0 }
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if !!session[:user_id]
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/tweets' do
      if session[:user_id]
        @tweets = Tweet.all
        erb :'tweets/tweets'
      else
        redirect to '/login'
      end
    end

    get '/tweets/new' do
      if session[:user_id]
        erb :'tweets/create_tweet'
      else
        redirect to '/login'
      end
    end

    post '/tweets' do
      if params[:content] == ""
        redirect to "/tweets/new"
      else
        user = User.find_by_id(session[:user_id])
        @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
        redirect to "/tweets/#{@tweet.id}"
      end
    end


end
