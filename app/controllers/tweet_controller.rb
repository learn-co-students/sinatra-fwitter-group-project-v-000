class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    #binding.pry
    if !(params[:content] == "")
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets' do
    #binding.pry
    if !(params[:content] == "")
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      current_user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    #binding.pry
    if (current_user == @tweet.user) && logged_in?
      @slug = @tweet.user.slug
      #binding.pry
      @tweet.destroy
      redirect "/users/#{@slug}"
    else
      redirect "/tweets"
    end
  end

end
