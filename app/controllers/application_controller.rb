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

  get '/tweets' do
# <<<<<<< HEAD


# =======
    if is_logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
# >>>>>>> f9e125e886b061a6dbed2c622dc8cd06e3ae2757
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
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
      if is_logged_in?
        @tweet = current_user.tweets.create(content: params[:content])
        redirect("/tweets/#{@tweet.id}")
      else
        redirect to '/login'
      end
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

#<<<<<<< HEAD
  delete '/tweets/:id/delete' do

    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])

      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end

  end
#=======


  get '/signup' do
    if !is_logged_in?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do

    if is_logged_in?
      redirect '/tweets'
    else
      if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
        @user = User.new(:username=> params[:username], :email => params[:email], :password => params[:password])
        if @user.save
          session[:user_id] = @user.id

          redirect '/tweets'
        else
          redirec to '/signup'
        end
# >>>>>>> f9e125e886b061a6dbed2c622dc8cd06e3ae2757
      else
        redirect to '/signup'
      end
    end
#=======

  end
#>>>>>>> d78bfaca004e2c1a75ba1e8c94ff4c6d91314e74
#>>>>>>> 9f9e8cdd1403923dee4cf24834d8318ec9a837bc
  get '/login' do
    if !is_logged_in?
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
       redirect to '/login'
     end
  end
  get '/logout' do
    if is_logged_in?
      session.destroy
      redirect to '/login'

    else
        redirect to '/'
    end
  end
  get '/users/:slug' do
    @user = current_user.username.slug
    @tweets = Tweet.find_by(@user.id)
    erb :'users/show'
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
