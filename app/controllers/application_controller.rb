require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sercet"
  end

  get '/' do
    erb :home
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
  user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
   else
      redirect to "/login"
   end
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], password: params[:password], email: params[:email])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.create(content: params[:content])
    if !!tweet && tweet.content != ""
      tweet.user = Helpers.current_user(session)
      tweet.save
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  delete '/tweets/:id/delete' do
    if Helpers.current_user(session) == Tweet.find(params[:id]).user
      Tweet.delete(params[:id])
    end
    redirect to '/tweets'
  end

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/tweets/all'
    else
      redirect to 'login'
    end
  end


  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/tweets/show'
    else
      redirect to 'login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      if Tweet.find(params[:id]).user == Helpers.current_user(session)
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/edit'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id/' do
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to "/tweets/#{params[:id]}"
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(:slug)
    erb :'/tweets/show'
  end



end
