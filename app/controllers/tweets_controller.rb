class TweetsController < ApplicationController

  get '/tweets' do

    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post'/tweets' do
    if
      @tweet = current_user.tweets.create(:content=> params[:content])
      redirect("/tweets/#{@tweet.id}")
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
       erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if
    if @tweet.update(content: params[:content])
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

   delete '/tweets/:id/delete' do
     @tweet = Tweet.find_by_id(params[:id])

     if logged_in?
       if @tweet.user_id == session[:user_id]
         @tweet.delete
         redirect to '/tweets'

       else
         redirect to '/tweets'
       end
     else
       redirect to '/login'
     end
   end

end
