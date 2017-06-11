
class TweetController<ApplicationController

get '/tweets' do
 if is_logged_in?
  erb :'tweets/tweets'
  else
  redirect '/login'
  end
end

get '/tweets/new' do
  if is_logged_in? 
  erb :'/tweets/create_tweet'
else
  redirect '/login'
  end
end

get '/tweets/:id' do
  if is_logged_in?
    @tweet=Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  else
    redirect "/login"
  end
end

get '/tweets/:id/edit' do 
  #binding.pry
  if is_logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit_tweet'
  else 
    redirect '/login'
  end

  end

  get '/logout' do
    session.clear if current_user
    redirect to '/login'
  end

post '/tweets' do
  if params[:content] == ""
  redirect "/tweets/new"
  else
  @tweet = Tweet.create(content: params[:content])
  current_user.tweets << @tweet
  redirect "/tweets/#{@tweet.id}"
end
end

delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
  if current_user == @tweet.user
    @tweet.destroy 
  end
  redirect "/tweets"
end

  patch '/tweets/:id/edit' do
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    else 
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == current_user.id
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
    end
    
  end
  end

  


end