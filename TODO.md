## TODO
  ### Model and Association
  - Create the file structure for the application.
   - file structure describe on learn.
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
   - create or find a gem that does this automatically

  - Need to setup my testing environment either in the rake file by reloading the env or a gem

  - Create 2 model User and Tweet. This both should inherit
  from Activerecord::Base

  - User table should include username, email, password and have my tweets

  - Tweets should have many content, belongs to a user.

 ### Controller

 - GET / response to the homepage that links to login page and signup page

  #### Create Tweet Controller

    - load the create tweet form
      - form should be loaded via a GET request to `/tweets/new`
    - one to process the form submission
      - tweet should be created and saved to the database

  #### Show Tweet

  #### Edit Tweet

  #### Delete Tweet

  #### Sign Up

  #### Log In

  #### Log Out

  #### Protecting The Views
    - creating helper methods


 > Sinatra::Base is this a namespace of Sinatra gem or SinatraActiveRecord gem ?
