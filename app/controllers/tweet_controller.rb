class TweetController < ApplicationController

  get '/tweets' do
    if User.is_logged_in?(session)
      @tweet = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if User.is_logged_in?(session)
      @user = User.current_user(session)
      erb :'/tweets/create_tweet'
    else
      redirect to "users/login"
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to "/tweets/new", locals: {message: "Your tweet was empty."}
    else
      @user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
      redirect to "/tweets/#{@tweet.id}", locals: {message: "Successfully created tweet."}
    end
  end

  get '/tweets/:id' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else 
      erb :'users/login'
    end
  end
end
