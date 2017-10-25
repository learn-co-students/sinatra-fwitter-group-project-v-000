class TweetsController < ApplicationController

<<<<<<< HEAD
  get '/tweets' do
    "hello world"
    erb :'tweets/tweets'
  end

  post '/tweets' do
    "hello world"
  end
  
  get '/tweets/create_tweet' do
    if logged_in?.empty?
      redirect "/users/login"
    else
      erb :'tweets/create_tweet'
    end
  end
end
=======
  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

end
>>>>>>> 98492d5eccd0078cc4f3572fe93844596fd67123
