class TweetController < ApplicationController


  get '/tweets' do
    if Helpers.logged_in?(session)
      @current_user = Helpers.current_user(session)
      @users = User.all
      erb :"/tweets"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      erb :"/tweets/create_tweet"
     else
       redirect to "/login"
    end
  end

    post '/tweets/new' do
      if Helpers.empty?(params)
        redirect to "/tweets/new"
      else
        @user = Helpers.current_user(session)
        @user = @user.tweets.build(content: params[:content])
        @user.save
        end
    end

    get '/tweets/:id' do
      @tweet = Tweet.find_by(id: params[:id])
      if Helpers.logged_in?(session)
        erb:"/tweets/show_tweet"
      else
        redirect to '/login'
      end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by(id: params[:id])
        if Helpers.logged_in?(session) && @tweet.user.id == session[:user_id]
         erb :"/tweets/edit_tweet"
       else
         redirect to '/login'
       end
    end

    patch '/tweets/:id/edit' do
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}/edit"
    end

    delete '/tweets/:id/delete' do
      @tweet = Tweet.find(params[:id])
      if !Helpers.logged_in?(session) ||    !User.find(session[:user_id]).tweets.include?(@tweet)
        redirect to '/tweets'
      else
        Tweet.find(params[:id]).destroy
      end
    end

end
