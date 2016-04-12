class TweetController < ApplicationController

  get '/tweets' do 
    if session[:id]
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do 
    if session[:id]
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do 
    if session[:id]
      redirect '/tweets/new' if params[:content].empty?

      @tweet = Tweet.new(content: params[:content])
      @tweet.user_id = session[:id]
      @tweet.save
      redirect "tweets/#{@tweet.id}"
    else
      redirect '/login'
    end
  end

  get '/tweets/:tweet_id' do 
    if session[:id]
      @tweet = Tweet.find(params[:tweet_id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:tweet_id/edit' do
    if session[:id]
      @tweet = Tweet.find(params[:tweet_id])
      if @tweet.user_id == session[:id]
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:tweet_id' do 
    if session[:id]
      redirect "/tweets/#{params[:tweet_id]}/edit" if params[:content].empty?

      @tweet = Tweet.find(params[:tweet_id])
      @tweet.content = params[:content]
      @tweet.save
    else
      redirect '/login'
    end
  end

  delete '/tweets/:tweet_id/delete' do
    if session[:id]
      @tweet = Tweet.find(params[:tweet_id])
      if @tweet.user_id == session[:id]
        @tweet.delete
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
 
end