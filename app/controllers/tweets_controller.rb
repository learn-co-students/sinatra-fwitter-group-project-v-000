class TweetsController < ApplicationController

  get '/tweets' do
      if is_logged_in?
        #@user = current_user
        @tweets = Tweet.all
        erb :'tweets/tweets'
      else
        redirect to '/login'
      end
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if is_logged_in? && params[:content] != ""
      @tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
      redirect to "/tweets"
  else
      redirect to "/tweets/new"
  end
 end

 get '/tweets/:id' do
   if is_logged_in?
     @tweet = Tweet.find_by_id(params[:id])
     erb :'/tweets/show'
 else
    redirect to '/login'
  end
 end

 get '/tweets/:id/edit' do
   if is_logged_in?
     @tweet = Tweet.find_by_id(params[:id])
     erb :'/tweets/edit'
   else
     redirect to '/login'
   end
 end

 patch '/tweets/:id/edit' do
  @tweet = Tweet.find_by_id(params[:id])
   if current_user.id == @tweet.user_id
     @tweet.update(content: params[:content])
   end
   if @tweet.content =! ""
     redirect to ("/tweets/#{@tweet.id}")
  else
    redirect to ("/tweets/#{@tweet.id}/edit")
 end
end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user.id == @tweet.user_id
    @tweet.delete
 end
end

end
