class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/'
    else
      @tweets = current_user.tweets
      erb :'tweets/index'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect to '/'
    else
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    @tweet = current_user.tweets.build(params)
    current_user.save
    redirect to '/tweets'
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect to '/'
    else
      if current_user
        current_tweet
        erb :'/tweets/show'
      else
        redirect to '/tweets'
      end
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to '/'
    else
      if current_user
        current_tweet
        erb :'/tweets/edit'
      else
        redirect to '/tweets'
      end
    end
  end

  patch '/tweets/:id' do
    if current_user
      current_tweet.update(content: params[:content])
      redirect to "/tweets/#{current_tweet.id}"
    else
      redirect to '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    if current_user
      current_tweet.delete
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end

end
