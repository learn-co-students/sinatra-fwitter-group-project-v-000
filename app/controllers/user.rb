class UserController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      redirect to "/tweets/tweets"
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    if params.value?("")
       redirect to "/signup"
     else
       user = User.find_or_create_by(params)
       session[:user_id]= user.id
       redirect to "/tweets"
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect to '/tweets'
    else
      erb :"/users/login"
    end

  end

  post '/login' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      redirect to '/tweets'
    elsif @user = Helpers.find_and_auth(params)
      session[:user_id]=@user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if Helpers.logged_in?(session)
        session.clear
        redirect to '/login'
    else
      redirect to '/login'
    end
  end

end
