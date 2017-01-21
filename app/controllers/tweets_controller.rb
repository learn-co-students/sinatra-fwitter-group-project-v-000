class TweetsController < ApplicationController
  get '/tweets' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    else
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/index'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    end
  end

  get '/tweets/:id' do #tweet show page
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    end
  end

  get '/tweets/:id/edit' do #tweet edit page
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    else
    @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        erb :'/tweets/edit'
      else
        redirect to '/tweets'
      end
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

end
