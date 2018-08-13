require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to '/tweets/create_tweet'
    else
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
    # @tweet = Tweet.new(params)
    # if logged_in? && @tweet.save
    #   current_user.tweets << @tweet
    #   redirect to "/tweets/#{@tweet.id}"
    # else
    #   redirect to '/tweets/new'
    # end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do #load edit form
    if logged_in? && current_user
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  # post '/tweets/:id' do #edit action
  #   if logged_in?
  #     if params[:content] == ""
  #       redirect to "/tweets/#{params[:id]}/edit"
  #     else
  #       @tweet = Tweet.find_by_id(params[:id])
  #       if @tweet && @tweet.user == current_user
  #         if @tweet.update(content: params[:content])
  #           redirect to "/tweets/#{@tweet.id}"
  #         else
  #           redirect to "/tweets/#{@tweet.id}/edit"
  #         end
  #       else
  #         redirect to '/tweets'
  #       end
  #     end
  #   else
  #     redirect to '/login'
  #   end
  # end

  patch '/tweets/:id' do #edit action
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.destroy
      end
        redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

#   post '/tweets/:id/delete' do
#   @tweet = Tweet.find_by_id(params[:id])
#   if session[:user_id]
#     @tweet = Tweet.find_by_id(params[:id])
#     binding
#     if @tweet.user_id == session[:user_id]
#       @tweet.delete
#       redirect to '/tweets'
#     else
#       redirect to '/tweets'
#     end
#   else
#     redirect to '/login'
#   end
# end

end
