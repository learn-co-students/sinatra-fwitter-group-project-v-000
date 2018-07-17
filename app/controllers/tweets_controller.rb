class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/users/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweets'
    else
      redirect '/users/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect '/tweets/new'
      else
        @tweet = crrent_user.tweets.build(content: params[:content])
        if @tweet.save
          redirect "/tweets/#{@tweet.id}"
        else
          redirect '/tweets/new'
        end
      end
    else
      redirect '/users/login'
    end
  end


  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.save
      erb :'/tweets/show_tweets'
    else
      redirect '/users/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'/tweets/edit_tweets'
      else
        redirect '/users/login'
      end
    else
      redirect '/users/login'
    end
  end

  patch '/tweets/:id' do
     if logged_in?
       if params[:content] == ""
         redirect "/tweets/#{params[:id]}/edit"
       else
         @tweet = Tweet.find_by_id(params[:id])
         if @tweet && @tweet.user == current_user
           if @tweet.update(content: params[:content])
             redirect  "/tweets/#{@tweet.id}"
           else
             redirect "/tweets/#{@tweet.id}/edit"
           end
         else
           redirect '/tweets'
         end
       end
     else
       redirect '/login'
     end
   end


  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect '/tweets/tweets'
    else
      redirect '/users/login'
    end
  end
end
