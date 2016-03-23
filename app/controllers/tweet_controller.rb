class TweetController < ApplicationController

  get '/tweets' do
    @tweet = Tweet.all
    @user = User.current_user(session)
    if User.is_logged_in?(session)
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
      redirect to "/login"
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
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    if User.is_logged_in?(session)
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if User.is_logged_in?(session)
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets", locals: {message: "Tweet was successfully edited."}
    end
  end

  delete '/tweets/:id/delete' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      if User.current_user(session).id == @tweet.user_id
        @tweet.delete
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
    
  end
end
