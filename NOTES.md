#Reading the instructions and specs:

## Class User
* attributes are :username, :email, and :password, all strings.

* must use 'has_secure_password', which will require a column in the 
database for :password_digest, also a string.

* must be Slugifiable, implementing user#slug, and user#find_by_slug  
(See module Slugifiable in Sinatra Playlister project)

## Class Tweet
* Tweets have :content, a string.  Should we also have datetime and/or title?

* Tweets belong_to :user, so will need a foreign key :user_id.

## Controllers
* ApplicationController is the only necessary controller

* Need these routes:

-* get '/' - loads Homepage

-* get '/signup' - load signup page

-* post '/signup' - process signup form submission, log in, redirect to '/tweets'
--* must have a username to sign up
--* must have an email to sign up
--* must have a password to sign up
--* does not let logged in user view the signup page, instead redirect to '/tweets'

-* get '/login'
--* log in user
--* redirects to '/tweets'
--* immediately redirects to '/tweets' if already logged in

-* get '/logout'
--* logs out the user, then redirects to '/login'
--* will not allow logout if not already logged in -> redirect to '/' instead

-* get '/tweets'
--* redirects to '/login' if not logged in
--* shows list of current user's tweets

