class TweetsController < ApplicationController

  get '/tweets' do
    if !Helpers.logged_in?(session)
      redirect "/login"
    else
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'/tweets/index'
    end
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content])
    @tweet.user_id = session[:user_id]

    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if Helpers.logged_in?(session)
      erb :'/tweets/show'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do 
    if Helpers.logged_in?(session)
      @tweet = Tweet.find(params[:id])
        if @tweet.user_id == session[:user_id]
          erb :'/tweets/edit'
        end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Helpers.current_user(session).tweets.find_by(id: params[:id])
    if @tweet
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "/login"
    end

    # @tweet = Tweet.find(params[:id])

    # if @tweet.user_id == session[:user_id]
    #   @tweet.destroy
    #   redirect "/tweets"
    # else
    #   redirect "/login"
    # end
  end

end