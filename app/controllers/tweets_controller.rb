class TweetsController < ApplicationController
	get '/tweets' do  
		if Helpers.logged_in?(session)
			@user=Helpers.current_user(session)
			erb :'tweets/index'
		else
			redirect '/login'
		end
	end

	get '/tweets/new' do  
		if Helpers.logged_in?(session)
			@user=Helpers.current_user(session)
			erb :'tweets/new'
		else
			redirect '/login'
		end
		
	end

	get '/tweets/:slug' do  
		if Helpers.logged_in?(session)
			@current_user=Helpers.current_user(session)
			@tweet = Tweet.find(params[:slug].to_i)
			erb :'tweets/view_tweet'
		else
			redirect '/login'
		end
		
	end

	post '/tweets/:slug/delete' do  
		#binding.pry
		@tweet = Tweet.find(params[:slug].to_i)
		if Helpers.can_edit?(session, @tweet)
			@tweet.delete
			puts "deleting tweet#{@tweet.id}"
			redirect '/tweets'
		else
			redirect '/login'
		end
		
	end



	get '/tweets/:slug/edit' do  
		
		#binding.pry
		if Helpers.logged_in?(session)
			@tweet = Tweet.find(params[:slug].to_i)
			if Helpers.can_edit?(session, @tweet)
				erb :'tweets/edit_tweet'
			else
				redirect '/login'
			end
		else
			redirect '/login'
		end
		
	end



	patch '/tweets/:slug' do  
		#binding.pry
		@tweet = Tweet.find(params[:slug].to_i)
		if Helpers.can_edit?(session, @tweet)
			if params[:content]==""
				redirect "/tweets/#{@tweet.id}/edit"
			end

			Helpers.modify_tweet(@tweet, params)
			@current_user=Helpers.current_user(session)
			@tweet = Tweet.find(params[:slug].to_i)
			redirect '/tweets'
		else
			redirect '/login'
		end
		
	end

	post '/tweets' do  
		#binding.pry
		if Helpers.logged_in?(session)
			#binding.pry
			if Helpers.current_user(session).id!=params[:user_id].to_i
				puts "Incorrect user"
				redirect '/login'
			elsif params[:content]==""
				puts "Incorrect user"
				redirect '/tweets/new'
			end

			t=Tweet.create(content: params[:content], user_id: params[:user_id].to_i)
			puts t
			redirect '/tweets'
		else
			puts "can't post new tweet if not logged in"
			redirect '/login'
		end
	end
end