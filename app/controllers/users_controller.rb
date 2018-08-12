class UsersController < ApplicationController

  get '/login' do
    redirect_to_tweets_if_logged_in(session)
    erb :login
  end

  get '/signup' do
    redirect_to_tweets_if_logged_in(session)
    erb :signup
  end

  post '/signup' do
    # instantiates new user based on submitted params
    @new_user = User.new(params)

    # if user can't be saved (due to a problem with input validation), go back to signup page
    if !@new_user.save
      # @message = @new_user.errors.  messages.values.flatten.join(" and ")
      redirect to '/signup'
    else
      @new_user.save
      session[:user_id] = @new_user.id
      redirect to '/tweets'
    end
  end

  post '/login' do
    redirect_to_tweets_if_logged_in(session)
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @tweets = User.find_by_slug(params[:slug]).tweets
    erb :'tweets/index'
  end

end
