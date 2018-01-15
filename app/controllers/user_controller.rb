class UserController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/signup' do
    if !session[:id]
      erb :'users/create_user'
    else
      redirect to "/tweets"
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(username: params[:username], email: params[:email], password_digest: params[:password])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    if !session[:id]
      erb :"users/login"
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    if User.find_by(username: params[:username])
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        redirect to "/tweets"
      end
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to "/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
end
