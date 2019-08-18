class TweetsController < ApplicationController

  configure do
    enable :sessions unless test?
    set :session_secret, "password_security"
  end

    get '/tweets/new' do
      if !logged_in?
        redirect to '/login'
      else
        @current_user = User.find_by_id(session[:user_id])
        erb :'/tweets/new'
      end
    end

    post '/tweets' do
      # binding.pry
      if params[:content] == ""
       redirect "/tweets/new"
     else
      @tweet = Tweet.create(content: params[:content])
      @current_user = User.find_by_id(session[:user_id])
      @tweet.user_id = @current_user.id
      @tweet.save
      end
      redirect to "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id' do
      if !logged_in?
        redirect to '/login'
      else
        @tweet = Tweet.find_by_id(params[:id])
        @current_user = User.find_by_id(session[:user_id])

        erb :'/tweets/show_tweet'
      end
    end

    # get '/tweets/:id/edit' do
    #   if !logged_in?
    #     redirect to '/login'
    #   else
    #     @tweet = Tweet.find_by_id(params[:id])
    #     @current_user = User.find_by_id(session[:user_id])
    #     # binding.pry
    #     if @tweet && @tweet.user = @current_user
    #     # @current_user.tweets.include?(@tweet)
    #       erb :'/tweets/edit_tweet'
    #     else
    #       redirect to "/tweets"
    #     end
    #   end
    # end

  #   get '/tweets/:id/edit' do
  #   if logged_in?
  #     @current_user = User.find_by_id(session[:user_id])
  #     @tweet = Tweet.find_by_id(params[:id])
  #     if @tweet && @tweet.user == @current_user
  #       erb :'tweets/edit_tweet'
  #     else
  #       redirect to '/tweets'
  #     end
  #   else
  #     redirect to '/login'
  #   end
  # end

  get '/tweets/:id/edit' do
  if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    # @current_user = User.find_by_id(session[:user_id])
    if @tweet && @tweet.user == current_user
      erb :'tweets/edit_tweet'
    else
      redirect to '/tweets'
    end
  else
    redirect to '/login'
  end
end


    # patch '/tweets/:id' do
    #   # binding.pry
    #   @tweet = Tweet.find_by_id(params[:id])
    #   @current_user = User.find_by_id(session[:user_id])
    #   if params[:content] == ""
    #    redirect "/tweets/#{@tweet.id}/edit"
    #   else
    #     if @tweet && @tweet.user == @current_user
    #       @tweet.update(content: params[:content])
    #       redirect to "/tweets/#{@tweet.id}"
    #     end
    #     redirect to "/tweets/#{@tweet.id}/edit"
    #   end
    #   redirect to "/login"
    # end

    # patch '/tweets/:id' do
    #   if logged_in?
    #     @tweet = Tweet.find_by_id(params[:id])
    #     @current_user = User.find_by_id(session[:user_id])
    #     if params[:content] == ""
    #       redirect "/tweets/#{@tweet.id}/edit"
    #     else
    #       @tweet && @tweet.user == @current_user
    #       @tweet.update(content: params[:content])
    #       redirect to "/tweets/#{@tweet.id}"
    #     end
    #     redirect to "/tweets/#{@tweet.id}/edit"
    #   else
    #     redirect to '/login'
    #   end
    # end

    patch '/tweets/:id' do
   if logged_in?
     if params[:content] == ""
       redirect to "/tweets/#{params[:id]}/edit"
     else
       @tweet = Tweet.find_by_id(params[:id])
       # User.find_by_id(session[:user_id])
       if @tweet && @tweet.user == current_user
         if @tweet.update(content: params[:content])
           redirect to "/tweets/#{@tweet.id}"
         else
           redirect to "/tweets/#{@tweet.id}/edit"
         end
       else
         redirect to '/tweets'
       end
     end
   else
     redirect to '/login'
   end
 end

 delete '/tweets/:id' do
   # binding.pry
  if logged_in?
  @tweet = Tweet.find_by_id(params[:id])
   if @tweet.user == current_user
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
