class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id] == nil
      redirect '/login'
    else
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if session[:user_id] == nil
      redirect '/login'
    else
      @user = User.find(session[:user_id])
      erb :'tweets/new'
    end
  end

  post '/tweets/new' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @user = User.find(session[:user_id])
      Tweet.create(content: params[:content], user_id: session[:user_id]).save
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id] == nil
      redirect '/login'
    else
      @id = params[:id]
      @user_tweet = User.find(session[:user_id]).tweets.find(@id).content
      erb :'tweets/edit_tweet'
    end
  end


  get '/tweets/:id' do
    if session[:user_id] == nil
      redirect '/login'
    else
      @users_tweet = User.find(session[:user_id]).tweets.find(params[:id]).content
      @id = params[:id]
      erb :'tweets/show_tweet'
    end
  end

  patch '/tweets/:id/edit' do
    @id = params[:id]
    if params[:content] == ""
      redirect "/tweets/#{@id}/edit"
    else
      @user_tweet = User.find(session[:user_id]).tweets.find(params[:id])
      @user_tweet.content = params[:content]
      @user_tweet.save
      redirect "/tweets/#{@id}"
    end
  end

  delete '/tweets/:id/delete' do
    @user_tweet = User.find(session[:user_id]).tweets.find(params[:id])
    @user_tweet.delete
    redirect to '/tweets'
  end

end

# post '/tweets/:id/edit' do
#   @id = params[:id]
#   if params[:content] == ""
#     redirect "/tweets/#{@id}/edit"
#   else
#     @user_tweet = User.find(session[:user_id]).tweets.find(params[:id])
#     @user_tweet.content = params[:content]
#     @user_tweet.save
#     redirect "/tweets/#{@id}"
#   end
# end
