class TweetsController < ApplicationController

	get("/tweets"){
		if logged_in?
			@tweets = Tweet.all
			erb :'tweets/tweets'
		else
			redirect to '/login'
		end
	}


	get('/tweets/new'){
		if logged_in?
			erb :'tweets/create_tweet'
		else
			redirect to '/login'
		end
	}


	post('/tweets'){
		if logged_in?
			if params[:content] != ""
				@tweet = Tweet.new(:content => params[:content])
				@tweet.user_id = current_user.id
				@tweet.save
				erb :'tweets/show_tweet'
			else
				redirect to 'tweets/new'
			end
		else
			redirect to '/login'
		end
	}

	  get('/tweets/:id'){
	    if logged_in?
	      @tweet = Tweet.find_by_id(params[:id])
	      erb :'tweets/show_tweet'
	    else
	      redirect to '/login'
	    end
	  }	


	get('/tweets/:id/edit'){
		if logged_in? 
			@tweet = Tweet.find_by_id(params[:id])
			if @tweet && @tweet.user = current_user
				erb :'tweets/edit_tweet'
			else
				redirect to '/tweets'
			end
		else
			redirect to '/login'
		end	 
	}


  patch '/tweets/:id' do
    if logged_in?
      if params[:updated_content] == ""
      	puts "redirecting to edit screen again"
        redirect to "/tweets/#{params[:id]}/edit"
      else
      	puts "assigning tweet successful"
        @tweet = Tweet.find_by_id(params[:id])
              	puts "assigning tweet successful"
 
        if @tweet && @tweet.user == current_user
        	puts "user and user id match"
          if @tweet.update(content: params[:updated_content])
          	puts "update successful"
            redirect to "/tweets/#{@tweet.id}"
          else 
          	puts "redirecting to edit screen again but bottom one"
            redirect to "/tweets/#{@tweet.id}/edit"
          end
        else 
        	puts "redirect to tweet cause user id failed"
          erb :'tweets/unable_edit'
        end
      end
    else 
    	puts "not logged on"
      redirect to '/login'
    end
  end

	delete('/tweets/:id/delete'){
		if logged_in?
			@tweet = Tweet.find_by_id(params[:id])

			if @tweet && @tweet.user == current_user
				@tweet.delete
			end
			erb :'tweets/unable_edit'

		else
			redirect to '/login'
		end

	}


end
