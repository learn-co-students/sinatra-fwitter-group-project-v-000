class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect to('/login')
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to('/login')
    end
  end

  post '/tweets' do
    @tweet = current_user.tweets.create(params)
    if @tweet.save
      redirect to('/tweets')
    else

      # add error message to session hash "session[:error]", then conditional to new tweet erb page

      redirect to('/tweets/new')
    end
  end


end
