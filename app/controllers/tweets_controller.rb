class TweetsController <ApplicationController

  get '/twewets' do
    if logged_in?
      @tweets= Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new'do
  if logged_in?
    erb :'tweets/tweets'
  else
    redirect '/login'
  end
end

post '/tweets' do
  if logged_in?
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @tweet = current_user.tweets.build(content: params[:content])
      if @tweet.save
        redirect '/tweets/#{@tweet.id}"
      else
        redirect '/tweets/new'
      end
    end
  else
    redirect '/login'
  end
end 
