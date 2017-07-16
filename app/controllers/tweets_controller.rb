class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end   
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    # should I use 'logged_in?' on POST/PATCH/DELETE/etc. routes?
    if logged_in?
      tweet = @current_user.tweets.new(content: params[:content])
      if tweet.save
        redirect "/tweets/#{tweet.id}"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = @current_user.tweets.find_by(id: params[:id])
      if @tweet
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      tweet = @current_user.tweets.find_by(id: params[:id])
      if tweet && !params[:content].empty? # is the second half of this conditional necessary or redundant w/ AR validation?
        tweet.content = params[:content]
        tweet.save
        redirect "/tweets/#{tweet.id}"
      else
        redirect "/tweets/#{params[:id]}/edit"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do 
    if logged_in?
      tweet = @current_user.tweets.find_by(id: params[:id])
      if tweet && tweet.destroy
        redirect '/tweets'
      else
        redirect "/tweets/#{params[:id]}"
      end
    else
      redirect '/login'
    end
  end
end
