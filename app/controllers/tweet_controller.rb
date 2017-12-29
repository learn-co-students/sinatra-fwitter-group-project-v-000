class TweetController<ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets=Tweet.all
      @username=current_user.username
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/new' do
    #binding.pry
    if params[:content].empty?
      redirect to '/tweets/new'
    else
      #binding.pry
      @tweet=Tweet.create(content: params[:content], user_id: current_user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end
\
  get '/tweets/:id' do
    if logged_in?
       @tweet = Tweet.find_by_id(params[:id])
       erb :'tweets/show_tweet'
     else
       redirect to '/login'
     end
  end

  get '/tweets/:id/edit' do
    if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id==session[:user_id]
      erb :'tweets/edit_tweet'
    end
    else
      redirect to '/login'
    end

  end


  patch '/tweets/:id' do
    if params[:content].empty?
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content=params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end


  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete if @tweet.user_id == session[:user_id]
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

end
