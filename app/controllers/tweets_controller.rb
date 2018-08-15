class TweetsController < ApplicationController

  get '/tweets/new' do #creates the create tweet page
    if logged_in?
    erb :'/tweets/create_tweet'
  else
    redirect '/login'
  end
  end

  post '/tweets' do  #create tweet
  # binding.pry

  #  binding.pry
    @user = User.find(session[:user_id])
    if !params[:content].empty? && logged_in?
    @tweet = Tweet.create(content: params[:content], user_id: @user.id)
    redirect "/tweets/#{@tweet.id}"
  else
   redirect '/login'
  end
end

  get '/tweets/:id' do #find/show
    if logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  else
   redirect '/login'
  end
  end

  get '/tweets/:id/edit' do #loads edit page
    #binding.pry
    if logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  else
    redirect '/login'
    end
  end

  post 'tweet/:id' do
    if !params[:content].empty?
    tweet = Tweet.update(content: params[:content])
    redirect '/tweets/:id'

    end
  end



  get '/tweets' do
  #  binding.pry
    if logged_in?
    @user = User.find_by(id: session[:user_id])
    erb:'/tweets/tweets'
  else
    redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    if current_user.id == @tweet.user_id && logged_in?
        @tweet.delete
        redirect '/login'
    end
  end

end
