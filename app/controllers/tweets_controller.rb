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
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in? && params[:content] == " "
        redirect '/tweets/new'
    else

    if @tweet = current_user.tweets.build(content: params[:content])
        redirect "/tweets/#{@tweet.id}"

        @tweet.save

    else

        redirect '/login'
        end
      end
    # end

    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by_id(:params[:id])
      erb :'tweets/show_tweet'

      else
      redirect '/login'
    end
  end





end
