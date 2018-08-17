class TweetsController < ApplicationController

get '/tweets' do
#  binding.pry
  if !!session[:user_id]
    @user = User.find_by_id(session[:user_id])
    erb :'tweets/tweets'
  else
    redirect '/login'
  end
#binding.pry

end

get '/tweets/new' do
  if !!session[:user_id]
    erb :'tweets/create_tweet'
  else
    redirect '/login'
  end
end

post '/tweets' do
 #binding.pry
  if params[:tweet][:content] == ""
    redirect to '/tweets/new'
  else
  @tweet = Tweet.create(content: params[:tweet][:content])
  @tweet.user_id = session[:user_id]
  @tweet.save
   redirect to "/tweets/#{@tweet.id}"
  end

end

get '/tweets/:id' do
  if !!session[:user_id]
@tweet = Tweet.find_by_id(params[:id])
erb :'tweets/show_tweet'
else
  redirect '/login'
  end
end

get '/tweets/:id/edit' do
  if !!session[:user_id]
    @tweet = Tweet.find_by_id(params[:id])
  erb :'tweets/edit_tweet'
  else
  redirect '/login'
  end
end

patch '/tweets/:id' do
  if params[:tweet][:content] == ""
    redirect "/tweets/#{params[:id]}/edit"
  end
@tweet = Tweet.find_by_id(params[:id])
@tweet.content = params[:tweet][:content]
@tweet.save
erb :'tweets/show_tweet'
end

delete '/tweets/:id/delete' do
    #binding.pry
    @tweet = Tweet.find_by_id(params[:id])
    if !session[:user_id]
      redirect to "/login"
    end
    if @tweet.user_id == session[:user_id]
    #binding.pry
      @tweet.delete
    redirect to "/tweets"
    else
      redirect to "/login"
    end
  end


end
