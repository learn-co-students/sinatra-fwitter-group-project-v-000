class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] != ""
        @tweet = current_user.tweets.create(:content => params[:content])
        redirect to '/tweets'
      else
        redirect to '/tweets/create_tweet'
      end
    else
      redirect to '/login'
    end
  end

end
