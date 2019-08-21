class TweetsController < ApplicationController
=begin
  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect "/tweets/new"
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      @tweet.save
      redirect "/tweets"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])

    if current_user.id == tweet.user_id
      tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in? && current_user.tweets.ids.include?(params[:id].to_i)
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    elsif logged_in? && !current_user.tweets.ids.include?(params[:id].to_i)
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/users/#{current_user.username.slugify}"
    end
  end
=end
end
