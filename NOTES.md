# From instructions and specs

## Classes
### Class User 
* attributes are :username, :email, and :password, all strings.

* must use 'has_secure_password', which will require a column in the 
database for :password_digest, also a string.

* must be Slugifiable, implementing user#slug, and user#find_by_slug  
(See module Slugifiable in Sinatra Playlister project)

### Class Tweet
* Tweets have :content, a string.  Should we also have datetime and/or title?

* Tweets belong_to :user, so will need a foreign key :user_id.

## Controllers
* ApplicationController is the only necessary controller, but I suppose we could
make others if we want to separate them out

* Need these routes:

  * get '/' - loads Homepage

  * get '/signup' - load signup page

  * post '/signup' - process signup form submission, log in, redirect to '/tweets'
    * must have a username to sign up
    * must have an email to sign up
    * must have a password to sign up
    * does not let logged in user view the signup page, instead redirect to '/tweets'

  * get '/login'
    * log in user, add message to session "Welcome, <user>" to be shown on '/tweets'
    * redirects to '/tweets'
    * immediately redirects to '/tweets' if already logged in

  * get '/logout'
    * logs out the user, then redirects to '/login'
    * will not allow logout if not already logged in -> redirect to '/' instead

  * get '/users/:user_slug'
    * shows all tweets from this user (no login necessary?)

  * get '/tweets'
    * redirects to '/login' if not logged in
    * shows list of all tweets

  * get '/tweets/new'
    * shows new tweet form if logged in
    * redirect to '/login' if not logged in

  * post '/tweets'
    * handle submission of a new tweet from logged in user
    * don't allow a blank tweet -> redirect to '/tweets/new'

  * get '/tweets/:tweet_id'
    * shows a tweet from the logged in user, with edit and delete buttons
    * redirect to '/login' if not logged in

  * get '/tweets/:tweet_id/edit'
    * redirect to '/login' if not logged in.
    * show edit form if this tweet belongs to current user
    * redirect to '/tweets' if this tweet belongs to someone else

  * post '/tweets/:tweet_id'
    * process submission of an edited tweet, if it belongs to current user
    * don't allow tweet with blank content, redirect to '/tweets/:tweet_id/edit'

  * post '/tweets/:tweet_id/delete'
    * don't delete tweet if it doesn't belong to current user, redirect to '/tweets'
    * delete tweet if it belongs to current user.  (Redirect to '/tweets'?)

## Views
    
### Homepage
  * views/index.html
    * Needs to include "Welcome to Fwitter" text
    * Needs links to Login and Signup password_digest

### Users
  * views/users/create_user
    * New User form (Sign up form)
  * views/users/login
    * Login Form

### Tweets
  * views/tweets/create_tweet
    * New Tweet
  * views/tweets/edit_tweet
    * Edit Tweet
  * views/tweets/show_tweet
    * Show Tweet
    * includes "Edit Tweet" and "Delete Tweet" buttons
  * views/tweets/tweets
    * Tweets index

## Helper methods
  ## Use #current_user and #logged_in? helper methods
    * sinatra-secure-password-lab
    * in the application_controller.rb file

## Additional Comments
* pay special attention to securing the views against 'hacking'.  Make sure
that only the owner of a tweet can edit or delete it, and that nobody
can create a tweet using someone else's identity.