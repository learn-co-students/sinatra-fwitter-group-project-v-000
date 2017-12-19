class TweetController < ApplicationController


  get '/tweets' do
    if Helpers.logged_in?(session)
      @current_user = Helpers.current_user(session)
      @users = User.all
      erb :"/tweets"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      erb :"/tweets/create_tweet"
     else
       redirect to "/login"
    end
  end

    post '/tweets/new' do
      if Helpers.empty?(params)
        redirect to "/tweets/new"
      else
        @user = Helpers.current_user(session)
        @user = @user.tweets.build(content: params[:content])
        @user.save
        end
    end

end
