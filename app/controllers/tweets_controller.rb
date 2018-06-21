class TweetsController < ApplicationController

  get '/tweets/new' do
    if !current_user
      redirect '/login'
    else
      erb :"tweets/create_tweet"
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:tweet][:content], user_id: current_user.id)
    if @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets' do
    if !current_user
      redirect '/login'
    else
      @tweets = Tweet.all

      erb :"tweets/tweets"
    end
  end

  get '/tweets/:id' do
    if !current_user
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])

      erb :"tweets/show_tweet"
    end
  end

  get '/tweets/:id/edit' do
    if !current_user
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit_tweet"
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:tweet][:content])
    @tweet.save
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if !current_user
      redirect '/login'
    else
      tweet = Tweet.find(params[:id])
      if current_user.tweets.include?(tweet)
        tweet.delete
        redirect "/users/#{current_user.slug}"
      else
        redirect "/tweets/#{tweet.id}"
      end
    end
  end

end
