class TweetController < ApplicationController

  get '/tweets' do
    if Helper.logged_in?(session)
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect :'/login'
    end

  end

  get '/tweets/new' do
    if Helper.logged_in?(session)
      erb :'/tweets/new'
    else
      redirect :'/login'
    end
  end

  get '/tweets/not_found' do
    erb :'/tweets/not_found'
  end

  post '/tweets' do
    if params["content"].empty?
      flash[:message] = "Your tweet can't be empty!"
      redirect :'/tweets/new'
    else
      @tweet = Tweet.new(params)
      @tweet.user_id = session[:user_id]
      @tweet.save
      flash[:message] = "Tweet successful!"
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if Helper.logged_in?(session)
      if @tweet = Tweet.find_by(id: params[:id])
        erb :'/tweets/show'
      else
        redirect '/tweets/not_found'
      end
    else
      flash[:message] = "You must be logged in to view a tweet."
      redirect :'/login'
    end
  end

  get '/tweets/:id/edit' do
    if !Helper.logged_in?(session)
      flash[:message] = "You must be logged in to edit your tweets."
      redirect :'/login'
    elsif @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user == Helper.current_user(session)
        erb :'/tweets/edit'
      else
        flash[:message] = "You may not edit another user's tweets."
        redirect :'/tweets'
      end
    else
      redirect '/tweets/not_found'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params["content"].empty?
      flash[:message] = "You cannot submit a blank tweet."
      redirect :"tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params["content"])
      flash[:message] = "Successfully edited tweet!"
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if !Helper.logged_in?(session)
      flash[:message] = "You must be logged in to delete a tweet."
      redirect :'/login'
    elsif @tweet.user == Helper.current_user(session)
      @tweet.destroy
      flash[:message] = "Successfully deleted your tweet."
      redirect :'/tweets'
    else
      flash[:message] = "You cannot delete another user's tweet."
      redirect :'/tweets'
    end
  end

end
