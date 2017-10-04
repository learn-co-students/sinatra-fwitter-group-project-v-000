class TweetController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all


      erb :"tweets/index"
    else
    redirect '/login'
  end
  end


  get '/tweets/new' do

    if is_logged_in?
    @user = User.find_by(params[:user])
    erb :"/tweets/create_tweet"

  else
     redirect '/login'
  end

  end

   post '/tweets' do
     @user = current_user
     @tweet = Tweet.new(content: params[:content], user_id: @user.id)
     if @tweet.content.empty?
       redirect '/tweets/new'
     end
     if @tweet.save
        redirect '/tweets'
    else
      redirect '/login'
    end



 end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if is_logged_in?

    erb :"tweets/show_tweet"

  else
    redirect '/login'
  end
end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if is_logged_in? && @tweet.user == current_user



    erb :"tweets/edit_tweet"

  else
    redirect to '/login'
  end

  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"

   elsif is_logged_in? &&  @tweet.user == current_user
    @tweet.update(content: params[:content])

    redirect to "/tweets"

  else
    redirect to '/login'
  end

  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if is_logged_in? && @tweet.user == current_user
    @tweet.delete

  end

  redirect to '/tweets'
  end


end
