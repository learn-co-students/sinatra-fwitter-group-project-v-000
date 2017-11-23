class TweetController < ApplicationController

    get '/tweets' do
      if logged_in?
        @user = current_user
      erb :'/tweets/tweets'
      else
        redirect '/login'
      end
    end


    get '/tweets/new' do
      if logged_in?
      erb :'/tweets/create_tweet'
      else
        redirect '/login'
      end
    end

    post '/tweets' do
      if params[:content] == ""
        redirect to('/tweets/new')
      else
        @tweet = Tweet.create(params)
        @tweet.user_id = current_user[:id]
        @tweet.save
        redirect to("/tweets/#{@tweet.id}")
      end
    end

    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.all.find(params[:id])
        erb :'/tweets/show_tweet'
      else
        redirect to('/login')
      end
    end

    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id == current_user.id
        erb :'/tweets/edit_tweet'
        else
          redirect to("/tweets/#{@tweet.id}")
        end
      else
        redirect to('/login')
      end
    end

    patch '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if params[:content] == ""
        redirect to("/tweets/#{@tweet.id}/edit")
      else
        @tweet.content = params[:content]
        @tweet.save
        redirect to("/tweets/#{@tweet.id}")
      end
    end

    delete '/tweets/:id/delete' do
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
      @tweet.destroy
      redirect to('/tweets')
      else
        redirect to("/tweets/#{@tweet.id}")
      end
    end
end
