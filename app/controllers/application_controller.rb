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
    if is_logged_in
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
# binding.pry
    @user=User.find_by(username: params["username"])
# binding.pry
    if @user && @user.authenticate(params["password"])
      session[:id]=@user[:id]
      redirect '/tweets'
# binding.pry
    else
      erb :failure
    end
  end

  get '/signup' do
# binding.pry
    if is_logged_in
# binding.pry
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
# binding.pry
    if is_logged_in
# binding.pry
      redirect '/tweets'
    elsif params.any?{|k,v| v==""}
# binding.pry 
      redirect '/signup'
# binding.pry
    else
# binding.pry
      @user=User.new(params)
  # binding.pry
      if @user.save
  # binding.pry
        session[:id]=@user.id
        redirect '/tweets'
      end
    end

  end

  get '/users/:slug' do
    @user=User.find_by_slug(params[:slug])
    erb :'tweets/tweets'
  end


  get '/tweets' do
    if is_logged_in
      @user=current_user
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in
      @user=current_user
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
# binding.pry
    if is_logged_in
# binding.pry
      if params["content"].empty?
        redirect '/tweets/new'
      end
      @tweet=Tweet.new(content: params["content"])
      @tweet.user_id=session[:id]
      @tweet.save
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if is_logged_in
      @tweet=Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in
      @tweet=Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    
    @tweet=Tweet.find(params[:id])
    if params["content"].empty?
      redirect "/tweets/#{params[:id]}/edit"
    end
    @tweet.content=params["content"]
# binding.pry
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
    
  end

  delete '/tweets/:id/delete' do
# binding.pry
    if is_logged_in
      @tweet=Tweet.find(params[:id])
      if @tweet.user_id==session[:id]
        @tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end

  end

  get '/logout' do
    session.clear
    redirect '/login'
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
            User.find(session[:id])
          end

          def is_logged_in
# binding.pry
            !!session[:id]
          end

          def taken?
            !User.where(params["user"]["email"]).empty?
          end
  end
end