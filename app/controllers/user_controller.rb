class UserController<ApplicationController

  get '/signup' do
    if is_logged_in?
    redirect "/tweets"
  else
    erb :'/users/create_user'
  end
end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
    redirect "/signup"
    else
      @user=User.create(params)
      @user.save
      session[:id] = @user.id
      redirect "/tweets"
      end
end

get '/login' do
  if is_logged_in?
    redirect "/tweets"
  else
  erb :'/users/login'
  end
end
post '/login' do
  @user=User.find_by(username: params[:username])
   if @user && @user.authenticate(params[:password])
     session[:id]=@user.id
     redirect "/tweets"
   end
end

get '/users/:slug' do
  @user = User.find_by_slug(params[:slug])
  erb :'/tweets/show_tweets'
end

get '/logout' do
if is_logged_in?
    session.clear
    redirect to "/login"
  end
    redirect "/"
end
end
