class TweetsController < ApplicationController

 	get '/tweets' do
 		if logged_in?
 			@tweets = Tweet.all
 			erb :'/tweets/index'
 		else
 			redirect to '/login'
 		end
 	end

 	get '/tweets/new' do
 		if logged_in?
 			erb :'tweets/new'
 		else
 			redirect to '/login'
 		end
 	end

  post '/tweets' do
      if params[:content] == ""
        redirect to "/tweets/new"
      else
        @tweet = current_user.tweets.create(content: params[:content])
        redirect to "/tweets/#{@tweet.id}"
      end
    end


 	get '/tweets/:id' do
 		if !logged_in?
 			redirect '/login'
 		end
 		@tweet = Tweet.find(params[:id])
 		erb :'tweets/show'
 	end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
       erb :'tweets/edit'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
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
 		@tweet = Tweet.find(params[:id])
 		if !logged_in?
 			redirect to '/login'
 		elsif current_user.tweets.include?(@tweet)
 			Tweet.find(params[:id]).destroy
 		end

 		redirect to '/tweets'
 	end
 end
