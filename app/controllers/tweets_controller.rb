class TweetsController < ApplicationController

  #Create
    get '/tweets/new' do
      if session[:user_id]
        erb :'tweets/create_tweet'
      else
        redirect to '/users/login'
      end
    end

    post'/tweets' do
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(:content=> params[:content], :user_id=> user.id)

      redirect("/tweets/#{@tweet.id}")
    end
  #Update/edit
    get '/tweets/:id/edit' do
      if session[:user_id]
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    end

    post '/tweets/:id' do
      @tweet = Tweet.create(params)
      @tweet.user = User.find(params[:username])

      redirect("/tweets/#{@tweet.id}")
    end
    #
     delete '/tweets/:id/delete' do
       if logged_in
         @tweet = Tweet.find_by_id(params[:id])
         if @tweet.user_id == current_user.id
           @tweet.delete
           redirect to '/tweets'
         else
           redirect to '/tweets'
         end
       else
         redirect to '/login'
       end
     end

  #Read

    get '/tweets/:id' do
      @tweet = Tweet.find_by_slug(params[:id])
      erb :'tweets/show_tweet'
    end

    get '/tweets' do
      @tweets = Tweet.all
      erb :'tweets/tweets'
    end

end
