class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  post "/login" do
  @user = User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to '/tweets'
  else
    erb :'users/login'
  end
end


  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
     erb :'users/login'
    end
  end

  post '/login' do
    if logged_in?
      redirect '/tweets'
    else
      @user = User.find_by(username: params[:username], password: params[:password])
        if @user == nil
          redirect '/login'
        else
          if user && user.authenticate(params[:password])
            login(@user.id)
            redirect '/tweets'
          else
            redirect '/login'
          end #38
        end # 35
      redirect '/tweets'
    end #31
  end #30

  get '/logout' do
    if logged_in?
      logout
      redirect '/login'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
