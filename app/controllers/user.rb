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
    if Helpers.empty?(params) #params.value?("")
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
    end
      redirect to '/login'
  end

  get '/users/:slug' do
     @user = User.all.detect{|obj| obj.slug == params[:slug]}.tweets
    erb :"/users/show"
  end



end
