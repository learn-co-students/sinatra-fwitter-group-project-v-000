require "./config/environment"

class TweetsController < ApplicationController

get '/tweets' do
    if Helpers.logged_in?(session)
        erb :'/tweets/tweets'
    else
        redirect '/login'
    end
    
end

get '/tweets/new' do
     if Helpers.logged_in?(session)
     @user = Helpers.current_user(session)
     erb :'/tweets/new'
     
     else
     redirect '/login'
     end
end


post '/tweets' do
    if Helpers.logged_in?(session) && params[:content] != ""
     @user = Helpers.current_user(session)
    @user.tweets << Tweet.create(:content => params[:content])
    @user.save
    redirect "/users/#{@user.username}/home"

    else
     redirect 'tweets/new'
    end

end


get '/tweets/:id' do
    if Helpers.logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
    else
    redirect '/login'
    end
end

get '/tweets/:id/edit' do
    if Helpers.logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
    else
    redirect '/login'
    end
end

post '/tweets/:id' do
if Helpers.logged_in?(session)

            if params[:content] != ""
                    @tweet = Tweet.find(params[:id])
                    @tweet.content = params[:content]
                    @tweet.save
                    redirect "/users/#{@tweet.user.slug}/home"
            else
                    redirect "/tweets/#{params[:id]}/edit"
            end
                


else
    redirect '/login'
    end
end




get '/tweets/:id/delete' do
if Helpers.logged_in?(session)

        if Helpers.current_user(session).id == Tweet.find(params[:id]).user.id
            Tweet.find(params[:id]).destroy
            redirect "/users/#{Helpers.current_user(session).slug}/home"
        else
            redirect '/tweets'
        end
        



else
redirect '/login'
end
end






end