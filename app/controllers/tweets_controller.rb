class TweetsController < ApplicationController


get '/tweets' do

end

get '/tweets/:id' do

end
post '/tweets/:id' do

end

get '/tweets/:id/edit' do

end

get '/tweets/new' do

  erb :create_tweet
end

post 'tweets/:id/delete' do

end

end
