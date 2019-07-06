class UsersController < ApplicationController
  configure do
    set :views, 'app/views'
  end

  get '/signup' do
    #binding.pry
    if !logged_in?
      erb :'/users/signup'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    #binding.pry
    if @user = User.find_by(username: params[:username])
      session[:user_id] = @user.id
      #raise "Username already exists. Try again."
    elsif params_present?
      @user = User.create(params)
      session[:user_id] = @user.id
    else
      return redirect to '/users/signup'
    end
    #binding.pry
    redirect to '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    if valid_login?
      @user = User.find_by(username: params[:username])
      session[:user_id] = @user.id
      @tweets = Tweet.all
    else
      redirect to '/login'
    end
    #binding.pry
    redirect to '/tweets'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @user_tweets = []
    if current_user == @user
      Tweet.all.each do |t|
        if t.user_id == current_user.id
          @user_tweets << t
        end
      end
    else
      redirect to '/login'
    end
    
    erb :'/users/show'
  end

  get '/logout' do
      session.clear

      redirect to '/login'
  end

end
