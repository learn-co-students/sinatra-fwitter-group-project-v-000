class TweetsController < ApplicationController

  get '/tweets' do
    if_logged_in do
      @tweets = Tweet.all.dup
      erb :'/tweets/index'
    end
  end


  get '/tweets/new' do
    if_logged_in do
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    current_user.tap do |user|

      if params[:content].chars.any?
        user.tweets.create(content: params[:content])
        redirect "/tweets/#{user.tweets.last.id}"
      else
        flash[:message] = "You can't post an empty tweet!"
        redirect '/tweets/new'
      end

    end
  end


  get '/tweets/:id' do
    if_logged_in do

      @tweet = Tweet.find(params[:id])

      erb :'/tweets/show'

    end
  end


  get '/tweets/:id/edit' do
    if_logged_in do

      @tweet = Tweet.find(params[:id])

      if current_user.owns?(@tweet)
        erb :'/tweets/edit'
      else
        flash[:message] = "You can't edit someone else's tweet!"
        redirect "/tweets/#{@tweet.id}"
      end

    end
  end

  patch '/tweets/:id' do
    if_logged_in do
      Tweet.find(params[:id]).tap do |tweet|

        if current_user.owns?(tweet)

          if params[:content].chars.any?
            tweet.update(content: params[:content])
            redirect "/tweets/#{tweet.id}"
          else
            flash[:message] = "You can't post an empty tweet!"
            redirect "/tweets/#{tweet.id}/edit"
          end

        else
          flash[:message] = "You can't edit someone else's tweet!"
          redirect "/tweets/#{tweet.id}"
        end

      end
    end
  end


  delete '/tweets/:id' do
    if_logged_in do
      Tweet.find(params[:id]).tap do |tweet|

        if current_user.owns?(tweet)

          tweet.delete
          flash[:message] = "Tweet successfully baweeted."
          redirect '/tweets'

        else
          flash[:message] = "You can't baweet someone else's tweet!"
          redirect "/tweets/#{tweet.id}"
        end

      end
    end
  end


end
