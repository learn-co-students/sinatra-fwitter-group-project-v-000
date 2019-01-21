class TweetsController < ApplicationController
  #
  get '/tweets' do
    # Is there a way to use helper methods?
    if !!session[:user_id]
      @user = User.find(session[:user_id])
      erb :'/tweets/index'
    else
      redirect "/login"
    end
  end


  get '/tweets/new' do
    # Is there a way to use helper methods?
    if !!session[:user_id]
      @user = User.find(session[:user_id])
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    # Is there a way to use helper methods?

    if !!session[:user_id] && params[:tweet][:content] != ""
      @tweet = Tweet.create(params[:tweet])
      # Need to assign user_id to tweet
      @tweet.user = User.find(session[:user_id])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    elsif !!session[:user_id] && params[:tweet][:content] == ""
      redirect "/tweets/new"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    # binding.pry
    if !!session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect "/login"
    end
  end

  # post '/tweets/:id/edit' do
  #   redirect "/tweets/:id/edit"
  # end

  get '/tweets/:id/edit' do
    # why does this pass the test: does not let a user edit a tweet they did not create
    @tweet = Tweet.find_by_id(params[:id])
    if !!session[:user_id] && @tweet.user_id == session[:user_id]

      erb :'/tweets/edit'
    elsif !!session[:user_id] && @tweet.user_id != session[:user_id]
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    # Need to assign user_id to tweet
    if params[:tweet][:content] != ""

      @tweet.update(params[:tweet])
      # @tweet.save
      redirect "/tweets/#{@tweet.id}"
    # undefined method id when content is empty
    elsif params[:tweet][:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if !!session[:user_id] && @tweet.user_id == session[:user_id]
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
