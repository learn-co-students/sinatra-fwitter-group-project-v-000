require 'pry'
class TweetsController < ApplicationController
  use Rack::Flash


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
    if logged_in?
      if params[:content] == " "
        redirect '/tweets/new'
      else
      @tweet = current_user.tweets.build(content: params[:content])
      @tweet.save
      # redirect '/tweets/#{@tweet.id}'
    end
  end
      # else
      #   redirect '/tweets/new'
      # end

  # else
  #   redirect '/login'
      # binding.pry



  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb  :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end
end

end
