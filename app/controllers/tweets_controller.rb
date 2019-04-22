class TweetsController <ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets= Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end


  get '/tweets/new' do
  if logged_in?
    redirect '/tweets'
  else
    redirect '/login'
  end
end


post '/tweets' do
  if logged_in?
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content])
      @tweet.user_id == user.id
      @tweet.save
        redirect "/tweets/#{@tweet.id}"
      end
    else
    redirect '/login'
    end
  end


    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
      else
        redirect '/login'
      end
    end



    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets'
          end
      else
        redirect '/login'
      end
    end

    patch '/tweets/:id' do
      if logged_in?
        if params[:content] == ""
          redirect "/tweets/#{params[:id]}/edit"
        else
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet && @tweet.user == current_user
            if @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
          else
            redirect "/tweets/#{@tweet.id}/edit"
          end
        else
            redirect '/tweets'
        end
      end
        else
            redirect '/login'
        end
      end

    #
      delete '/tweets/:id/delete' do
      if logged_in?
        @tweet = Tweet.find_by(content[:user_id])
        @tweet.delete
      else
         @tweet && @tweet.user == !current_user
            redirect '/login'
        end
    end
end
