class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

    get '/tweets/new' do
      if logged_in?
        erb :'/tweets/create_tweet'
      else
        redirect to "/login"
      end
    end

    post '/tweets' do
       if params[:content] == ""
         redirect '/tweets/new'
       else
         @tweet = Tweet.create(:content => params["content"])
         @tweet.user_id = current_user.id
         @tweet.save
         redirect to "/tweets/#{@tweet.id}"
       end
     end


    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show_tweet'
      else
        redirect to "/login"
      end
    end

    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/edit_tweet'
      else
        redirect to "/login"
      end
    end

    post '/tweets/:id' do
      @tweet = Tweet.find_by_id(params[:id])
      if params[:content] != ""
        @tweet.update(:content => params[:content])
        reditect to "/tweets/#{@tweet.id}"
      else
        reditect to "/tweets/#{@tweet.id}/edit"
      end

    end

    delete '/tweets/:id' do
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
      end
      reditect to '/tweets'
    end

end
