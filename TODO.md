## TODO
  ### Model and Association
  - [ ] Create the file structure for the application.
   -  [ ] file structure describe on learn.
   ```
   ├── CONTRIBUTING.md
   ├── Gemfile
   ├── Gemfile.lock
   ├── LICENSE.md
   ├── README.md
   ├── Rakefile
   ├── app
   │   ├── controllers
   │   │   └── application_controller.rb
   │   ├── models
   │   │   ├── tweet.rb
   │   │   └── user.rb
   │   └── views
   │       ├── index.erb
   │       ├── layout.erb
   │       ├── tweets
   │       │   ├── create_tweet.erb
   │       │   ├── edit_tweet.erb
   │       │   ├── show_tweet.erb
   │       │   └── tweets.erb
   │       └── users
   │           ├── create_user.erb
   │           └── login.erb
   │           └── show.erb
   ├── config
   │   └── environment.rb
   ├── config.ru
   ├── db
   │   ├── development.sqlite
   │   ├── migrate
   │   │   ├── 20151124191332_create_users.rb
   │   │   └── 20151124191334_create_tweets.rb
   │   ├── schema.rb
   │   └── test.sqlite
   └── spec
       ├── controllers
       │   └── application_controller_spec.rb
       └── spec_helper.rb
   ```
   - [ ] create or find a gem that does this automatically

  - [ ] Need to setup my testing environment either in the rake file by reloading the env or a gem

  - [ ] Create 2 model User and Tweet. This both should inherit
  from Activerecord::Base

  - [ ] User table should include username, email, password and have my tweets

  - [ ] Tweets should have many content, belongs to a user.

 ### Controller

 - [ ] GET / response to the homepage that links to login page and signup page

  #### Create Tweet Controller

    - [ ] load the create tweet form
      - [ ] form should be loaded via a GET request to `/tweets/new`
    - [ ] one to process the form submission
      - [ ] tweet should be created and saved to the database

  #### Show Tweet

    - [ ] `/tweets/:id` display the info of a single tweet

  #### Edit Tweet
    - [ ] `/tweets/:id/edit` loads the edit form
    - [ ] `/tweets/:id` form submission via POST
    - [ ] create an edit link on the tweet show page

  #### Delete Tweet
    - [ ] one controller is need to delete a tweet
    - [ ] just a submit button is needed
    - [ ] the form submits to POST `tweets/:id/delete`

  #### Sign Up
    - [ ] 2 controllers
    - [ ] Make sure you add the Signup link to the home page
    - [ ] one to display the user signup
      GET `/signup`
    controller action that processes the form submission should create the user and save it to the database.
      - [ ] The signup action should also log the user in and add the user_id to the sessions hash.
    - [ ] one to process the form submission

  #### Log In
     - [ ] You'll need two more controller actions
      - [ ] display the form to log in
      - [ ] one to log add the `user_id` to the sessions hash
      - [ ] The form to login should be loaded via a GET   request to `/login` and submitted via a POST request to `/login`

  #### Log Out
    - [ ] You'll need to create a controller action to process a GET request to /logout to log out. The controller action should clear the session hash

  #### Protecting The Views
    - [ ] create two helper methods `current_user` and `logged_in?` (no one can create, read, edit or delete any tweets)

    > **Use these helper methods to block content if a user is not logged in**
