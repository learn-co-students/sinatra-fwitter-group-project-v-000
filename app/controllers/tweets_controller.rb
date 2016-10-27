class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
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
    if params[:content] == ""
      redirect "/tweets/new"
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

end