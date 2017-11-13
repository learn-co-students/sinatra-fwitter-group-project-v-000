class TweetController < ApplicationController
  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?(session)
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.new(params)
      tweet.user_id = session[:id]
      tweet.save
      redirect to '/tweets'
    end

    redirect to '/tweets/new'
  end

  get '/tweets/:id' do
    if logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    #@tweet = Tweet.find(params[:id])
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?(session) && User.current_user(session).id == @tweet.user_id
      erb :'/tweets/edit_tweet'
    elsif logged_in?(session) && User.current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    else #!logged_in?(session)
      redirect to '/login'
    end
  end

  post '/tweets/:id' do

    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in?(session) && User.current_user(session).id == @tweet.user_id
      @tweet.delete
      redirect to '/tweets'
    elsif logged_in?(session) && User.current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
end
