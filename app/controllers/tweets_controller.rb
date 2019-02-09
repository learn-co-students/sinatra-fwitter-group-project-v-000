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
    if logged_in?
      if params[:tweet]["content"] == ""
        redirect '/tweets/new'
      else
        @tweet = Tweet.new(params[:tweet])
        current_user.tweets << @tweet
        @tweet.save
        #binding.pry
        redirect "/tweets/#{@tweet.id}"
      end
    end
  end

  get '/tweets/:id' do
    #binding.pry
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      #binding.pry
      if current_user.id == @tweet.user_id
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do

    #binding.pry
    if logged_in?
      if params[:tweet]["content"] == ""
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && current_user.id == @tweet.user_id
          if @tweet.update(params[:tweet])
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
          else
            redirect "/tweets/#{@tweet.id}/edit"
          end
        end
      end
      else
        redirect '/login'
      end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    #binding.pry
    if logged_in?
      if current_user.id == @tweet.user_id

        @tweet.delete
        redirect '/tweets'
      end

    else
      redirect '/login'
    end
  end

end
