class TweetsController < ApplicationController

  get "/tweets" do
    redirect_if_not_logged_in
    @tweets = Tweet.all
    erb :"/tweets/index"
  end

   get "/tweets/new" do
     redirect_if_not_logged_in
    erb :"/tweets/new"
   end

   post "/tweets" do
     #binding.pry
     redirect_if_not_logged_in
      if params[:content].empty?
        flash[:message] = "Something went wrong. You cannot post an empty tweet"
        redirect '/tweets/new'
      else
        @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
        flash[:message] = "Tweet successfully created."
        redirect "/tweets/#{@tweet.id}"
      end
    end

   get "/tweets/:id" do
     redirect_if_not_logged_in
     @tweet = Tweet.find(params[:id])
     erb :'/tweets/show_tweet'
   end

   post "/tweets/:id" do
     redirect_if_not_logged_in
     @tweet = Tweet.find(params[:id]) #@tweet.update(params.select{|k|k=="content"})
     @tweet.update(content: params[:content])
     redirect "/tweets/#{@tweet.id}"
   end

  get "/tweets/:id/edit" do
    redirect_if_not_logged_in
    @tweet = Tweet.find(params[:id])
        erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
   #binding.pry
    redirect_if_not_logged_in
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      flash[:error] = "You cannot post a tweet void of content. Please try again with content inside of the textarea before pressing submit."
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      flash[:message] = "Successfully edited that Tweet."
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id' do
    redirect_if_not_logged_in
    @tweet = Tweet.find(params[:id])
    if authorized_to_edit?(@tweet)
      @tweet.destroy
      flash[:message] = "Successfully deleted that Tweet."
      redirect '/'
    else
      flash[:error] = "Error. Did not delete."
      redirect '/tweets'
    end
  end

end
