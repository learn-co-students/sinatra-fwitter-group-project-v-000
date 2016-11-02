class TweetController < ApplicationController


  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if Helpers.logged_in?(session) && params["tweet"] != ""
      @tweet = Tweet.new(:content => params["tweet"])
      @user = User.find(session[:user_id])
      @user.tweets << Tweet.create(:content => params["tweet"])
      @user.save
      redirect '/tweets'
    elsif params["tweet"] == ""
      redirect '/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if !Helpers.logged_in?(session)
      redirect '/login'
    else
      @tweet= Tweet.all
      erb :'tweets/tweets'
    end
  end

  get '/tweets/:id' do
    @tweet= Tweet.find(params[:id])
    if Helpers.logged_in?(session) &&  Helpers.current_user(session).tweets.include?(@tweet)
      erb :'tweets/show_tweet'
    elsif Helpers.logged_in?(session)
      redirect '/users/:slug'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !Helpers.logged_in?(session)
      redirect '/login'
    @tweet= Tweet.find(params[:id])
  elsif Helpers.logged_in?(session) && Helpers.current_user(session).tweets.include?(@tweet)
      erb :'/tweets/edit_tweet'
    else
      redirect '/tweets'
    end
  end

  patch '/tweets/:id' do
    if Helpers.logged_in?(session) && params["tweet"] == ""
      @tweet = Tweet.find(params[:id])
      redirect "/tweets/#{@tweet.id}/edit"
    elsif Helpers.logged_in?(session)
      @tweet = Tweet.find(params[:id])
      @tweet.update(:content => params["tweet"])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if Helpers.logged_in?(session) && Helpers.current_user(session).tweets.include?(@tweet)
    @tweet.delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

end
