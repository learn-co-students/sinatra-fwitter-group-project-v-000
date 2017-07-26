class TweetController < ApplicationController

  patch '/tweets/:id' do
    user = current_user
     if user.tweets.include?(Tweet.find(params[:id]))
          tweet = Tweet.find(params[:id])
          tweet.content = params[:content]
          if tweet.save
              redirect to "/tweets/#{tweet.id}"
          else
              redirect to "/tweets/#{tweet.id}/edit"
          end
      else
        redirect to '/tweets'
      end
  end

  get '/tweets' do
    if logged_in?

        @user = current_user
        @tweets = Tweet.all
        erb :'tweets/tweets'
    else
        redirect to '/login'
    end
  end

  post '/tweets' do
    user = current_user
    tweet = Tweet.create(content: params[:content])
    tweet.user = user
    if tweet.save     
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show_tweet'
    else
        redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'tweets/edit_tweet'
    else
        redirect to "/login"
    end
  end

  delete "/tweets/:id/delete" do
    user = current_user

    if user.tweets.include?(Tweet.find(params[:id]))
        tweet = Tweet.find(params[:id])
        tweet.delete
        redirect to '/tweets'
    else
        redirect to '/tweets'
    end
  end
 

end