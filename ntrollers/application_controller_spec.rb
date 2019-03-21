Run options: include {:focus=>true}

All examples were filtered out; ignoring {:focus=>true}
[32m.[0m[32m.[0m[31mF[0m[32m.[0m[32m.[0m[32m.[0m[31mF[0m[32m.[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[31mF[0m[32m.[0m[32m.[0m[32m.[0m

Failures:

  1) ApplicationController Signup Page signup directs user to twitter index
     [31mFailure/Error: [0m[32mexpect[0m(last_response.location).to include([31m[1;31m"[0m[31m/tweets[1;31m"[0m[31m[0m)[0m
     [31m  expected "http://example.org/login" to include "/tweets"[0m
     [36m# ./spec/controllers/application_controller_spec.rb:28:in `block (3 levels) in <top (required)>'[0m

  2) ApplicationController Signup Page creates a new user and logs them in on valid submission and does not let a logged in user view the signup page
     [31mFailure/Error: [0m[32mexpect[0m(last_response.location).to include([31m[1;31m'[0m[31m/tweets[1;31m'[0m[31m[0m)[0m
     [31m  expected nil to include "/tweets", but it does not respond to `include?`[0m
     [36m# ./spec/controllers/application_controller_spec.rb:69:in `block (3 levels) in <top (required)>'[0m

  3) ApplicationController login loads the tweets index after login
     [31mFailure/Error: [0m[32mexpect[0m(last_response.body).to include([31m[1;31m"[0m[31mWelcome,[1;31m"[0m[31m[0m)[0m
     [31m[0m
     [31m  expected "<!doctype html>\n<html>\n  <head>\n    <title>Fwitter</title>\n  </head>\n  <body>\n\n    <div class...t forget to <strong>yield</strong> your views!</h2>\n\n      \n\n    </div>\n\n  </body>\n</html>\n" to include "Welcome,"[0m
     [31m  Diff:[0m[0m
     [31m  [0m[34m@@ -1,2 +1,19 @@[0m
     [31m  [0m[31m-Welcome,[0m
     [31m  [0m[32m+<!doctype html>[0m
     [31m  [0m[32m+<html>[0m
     [31m  [0m[32m+  <head>[0m
     [31m  [0m[32m+    <title>Fwitter</title>[0m
     [31m  [0m[32m+  </head>[0m
     [31m  [0m[32m+  <body>[0m
     [31m  [0m[32m+[0m
     [31m  [0m[32m+    <div class="container">[0m
     [31m  [0m[32m+      <h1>Welcome to Fwitter!</h1>[0m
     [31m  [0m[32m+      <h2>This is located in layout.erb!</h2>[0m
     [31m  [0m[32m+      <h2>Don't forget to <strong>yield</strong> your views!</h2>[0m
     [31m  [0m[32m+[0m
     [31m  [0m[32m+      [0m
     [31m  [0m[32m+[0m
     [31m  [0m[32m+    </div>[0m
     [31m  [0m[32m+[0m
     [31m  [0m[32m+  </body>[0m
     [31m  [0m[32m+</html>[0m
     [31m  [0m[0m
     [36m# ./spec/controllers/application_controller_spec.rb:89:in `block (3 levels) in <top (required)>'[0m

  4) ApplicationController login does not let user view login page if already logged in
     [31mFailure/Error: [0m[32mexpect[0m(last_response.location).to include([31m[1;31m"[0m[31m/tweets[1;31m"[0m[31m[0m)[0m
     [31m  expected nil to include "/tweets", but it does not respond to `include?`[0m
     [36m# ./spec/controllers/application_controller_spec.rb:100:in `block (3 levels) in <top (required)>'[0m

  5) ApplicationController logout lets a user logout if they are already logged in
     [31mFailure/Error: [0m[32mexpect[0m(last_response.location).to include([31m[1;31m"[0m[31m/login[1;31m"[0m[31m[0m)[0m
     [31m  expected nil to include "/login", but it does not respond to `include?`[0m
     [36m# ./spec/controllers/application_controller_spec.rb:114:in `block (3 levels) in <top (required)>'[0m

  6) ApplicationController logout does not let a user logout if not logged in
     [31mFailure/Error: [0m[32mexpect[0m(last_response.location).to include([31m[1;31m"[0m[31m/[1;31m"[0m[31m[0m)[0m
     [31m  expected nil to include "/", but it does not respond to `include?`[0m
     [36m# ./spec/controllers/application_controller_spec.rb:119:in `block (3 levels) in <top (required)>'[0m

  7) ApplicationController logout does not load /tweets if user not logged in
     [31mFailure/Error: [0m[32mexpect[0m(last_response.location).to include([31m[1;31m"[0m[31m/login[1;31m"[0m[31m[0m)[0m
     [31m  expected nil to include "/login", but it does not respond to `include?`[0m
     [36m# ./spec/controllers/application_controller_spec.rb:124:in `block (3 levels) in <top (required)>'[0m

  8) ApplicationController logout does load /tweets if user is logged in
     [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
     [31m[0m
     [31mCapybara::ElementNotFound:[0m
     [31m  Unable to find button "submit"[0m
     [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
     [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
     [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
     [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
     [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
     [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
     [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
     [36m# ./spec/controllers/application_controller_spec.rb:135:in `block (3 levels) in <top (required)>'[0m

  9) ApplicationController user show page shows all a single users tweets
     [31mFailure/Error: [0m[32mexpect[0m(last_response.body).to include([31m[1;31m"[0m[31mtweeting![1;31m"[0m[31m[0m)[0m
     [31m[0m
     [31m  expected "<!DOCTYPE html>\n<html>\n<head>\n  <style type=\"text/css\">\n  body { text-align:center;font-family...2F;becky567&#x27; do\n    &quot;Hello World&quot;\n  end\nend\n</pre>\n  </div>\n</body>\n</html>\n" to include "tweeting!"[0m
     [31m  Diff:[0m[0m
     [31m  [0m[34m@@ -1,2 +1,25 @@[0m
     [31m  [0m[31m-tweeting![0m
     [31m  [0m[32m+<!DOCTYPE html>[0m
     [31m  [0m[32m+<html>[0m
     [31m  [0m[32m+<head>[0m
     [31m  [0m[32m+  <style type="text/css">[0m
     [31m  [0m[32m+  body { text-align:center;font-family:helvetica,arial;font-size:22px;[0m
     [31m  [0m[32m+    color:#888;margin:20px}[0m
     [31m  [0m[32m+  #c {margin:0 auto;width:500px;text-align:left}[0m
     [31m  [0m[32m+  </style>[0m
     [31m  [0m[32m+</head>[0m
     [31m  [0m[32m+<body>[0m
     [31m  [0m[32m+  <h2>Sinatra doesn’t know this ditty.</h2>[0m
     [31m  [0m[32m+  <img src='http://example.org/__sinatra__/404.png'>[0m
     [31m  [0m[32m+  <div id="c">[0m
     [31m  [0m[32m+    Try this:[0m
     [31m  [0m[32m+    <pre># in application_controller.rb[0m
     [31m  [0m[32m+class ApplicationController[0m
     [31m  [0m[32m+  get &#x27;&#x2F;users&#x2F;becky567&#x27; do[0m
     [31m  [0m[32m+    &quot;Hello World&quot;[0m
     [31m  [0m[32m+  end[0m
     [31m  [0m[32m+end[0m
     [31m  [0m[32m+</pre>[0m
     [31m  [0m[32m+  </div>[0m
     [31m  [0m[32m+</body>[0m
     [31m  [0m[32m+</html>[0m
     [31m  [0m[0m
     [36m# ./spec/controllers/application_controller_spec.rb:147:in `block (3 levels) in <top (required)>'[0m

  10) ApplicationController index action logged in lets a user view the tweets index if logged in
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:166:in `block (4 levels) in <top (required)>'[0m

  11) ApplicationController index action logged out does not let a user view the tweets index if not logged in
      [31mFailure/Error: [0m[32mexpect[0m(last_response.location).to include([31m[1;31m"[0m[31m/login[1;31m"[0m[31m[0m)[0m
      [31m  expected nil to include "/login", but it does not respond to `include?`[0m
      [36m# ./spec/controllers/application_controller_spec.rb:176:in `block (4 levels) in <top (required)>'[0m

  12) ApplicationController new action logged in lets user view new tweet form if logged in
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:190:in `block (4 levels) in <top (required)>'[0m

  13) ApplicationController new action logged in lets user create a tweet if they are logged in
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:202:in `block (4 levels) in <top (required)>'[0m

  14) ApplicationController new action logged in does not let a user tweet from another user
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:223:in `block (4 levels) in <top (required)>'[0m

  15) ApplicationController new action logged in does not let a user create a blank tweet
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:245:in `block (4 levels) in <top (required)>'[0m

  16) ApplicationController new action logged out does not let user view new tweet form if not logged in
      [31mFailure/Error: [0m[32mexpect[0m(last_response.location).to include([31m[1;31m"[0m[31m/login[1;31m"[0m[31m[0m)[0m
      [31m  expected nil to include "/login", but it does not respond to `include?`[0m
      [36m# ./spec/controllers/application_controller_spec.rb:260:in `block (4 levels) in <top (required)>'[0m

  17) ApplicationController show action logged in displays a single tweet
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:276:in `block (4 levels) in <top (required)>'[0m

  18) ApplicationController show action logged out does not let a user view a tweet
      [31mFailure/Error: [0m[32mexpect[0m(last_response.location).to include([31m[1;31m"[0m[31m/login[1;31m"[0m[31m[0m)[0m
      [31m  expected nil to include "/login", but it does not respond to `include?`[0m
      [36m# ./spec/controllers/application_controller_spec.rb:291:in `block (4 levels) in <top (required)>'[0m

  19) ApplicationController edit action logged in lets a user view tweet edit form if they are logged in
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:305:in `block (4 levels) in <top (required)>'[0m

  20) ApplicationController edit action logged in does not let a user edit a tweet they did not create
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:322:in `block (4 levels) in <top (required)>'[0m

  21) ApplicationController edit action logged in lets a user edit their own tweet if they are logged in
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:334:in `block (4 levels) in <top (required)>'[0m

  22) ApplicationController edit action logged in does not let a user edit a text with blank content
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:352:in `block (4 levels) in <top (required)>'[0m

  23) ApplicationController edit action logged out does not load -- instead redirects to login
      [31mFailure/Error: [0m[32mexpect[0m(last_response.location).to include([31m[1;31m"[0m[31m/login[1;31m"[0m[31m[0m)[0m
      [31m  expected nil to include "/login", but it does not respond to `include?`[0m
      [36m# ./spec/controllers/application_controller_spec.rb:366:in `block (4 levels) in <top (required)>'[0m

  24) ApplicationController delete action logged in lets a user delete their own tweet if they are logged in
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:380:in `block (4 levels) in <top (required)>'[0m

  25) ApplicationController delete action logged in does not let a user delete a tweet they did not create
      [31mFailure/Error: [0mclick_button [31m[1;31m'[0m[31msubmit[1;31m'[0m[31m[0m[0m
      [31m[0m
      [31mCapybara::ElementNotFound:[0m
      [31m  Unable to find button "submit"[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:301:in `block in synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/base.rb:83:in `synchronize'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:292:in `synced_resolve'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/finders.rb:47:in `find'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/node/actions.rb:57:in `click_button'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/session.rb:732:in `block (2 levels) in <class:Session>'[0m
      [36m# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-3.12.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'[0m
      [36m# ./spec/controllers/application_controller_spec.rb:398:in `block (4 levels) in <top (required)>'[0m

  26) ApplicationController delete action logged out does not load let user delete a tweet if not logged in
      [31mFailure/Error: [0m[32mexpect[0m(page.current_path).to eq([31m[1;31m"[0m[31m/login[1;31m"[0m[31m[0m)[0m
      [31m[0m
      [31m  expected: "/login"[0m
      [31m       got: "/tweets/1"[0m
      [31m[0m
      [31m  (compared using ==)[0m
      [36m# ./spec/controllers/application_controller_spec.rb:411:in `block (4 levels) in <top (required)>'[0m

Finished in 3 seconds (files took 1.35 seconds to load)
[31m35 examples, 26 failures[0m

Failed examples:

[31mrspec ./spec/controllers/application_controller_spec.rb:21[0m [36m# ApplicationController Signup Page signup directs user to twitter index[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:61[0m [36m# ApplicationController Signup Page creates a new user and logs them in on valid submission and does not let a logged in user view the signup page[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:79[0m [36m# ApplicationController login loads the tweets index after login[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:92[0m [36m# ApplicationController login does not let user view login page if already logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:105[0m [36m# ApplicationController logout lets a user logout if they are already logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:117[0m [36m# ApplicationController logout does not let a user logout if not logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:122[0m [36m# ApplicationController logout does not load /tweets if user not logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:127[0m [36m# ApplicationController logout does load /tweets if user is logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:141[0m [36m# ApplicationController user show page shows all a single users tweets[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:155[0m [36m# ApplicationController index action logged in lets a user view the tweets index if logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:174[0m [36m# ApplicationController index action logged out does not let a user view the tweets index if not logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:183[0m [36m# ApplicationController new action logged in lets user view new tweet form if logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:195[0m [36m# ApplicationController new action logged in lets user create a tweet if they are logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:215[0m [36m# ApplicationController new action logged in does not let a user tweet from another user[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:238[0m [36m# ApplicationController new action logged in does not let a user create a blank tweet[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:258[0m [36m# ApplicationController new action logged out does not let user view new tweet form if not logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:267[0m [36m# ApplicationController show action logged in displays a single tweet[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:287[0m [36m# ApplicationController show action logged out does not let a user view a tweet[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:298[0m [36m# ApplicationController edit action logged in lets a user view tweet edit form if they are logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:311[0m [36m# ApplicationController edit action logged in does not let a user edit a tweet they did not create[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:327[0m [36m# ApplicationController edit action logged in lets a user edit their own tweet if they are logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:345[0m [36m# ApplicationController edit action logged in does not let a user edit a text with blank content[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:364[0m [36m# ApplicationController edit action logged out does not load -- instead redirects to login[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:373[0m [36m# ApplicationController delete action logged in lets a user delete their own tweet if they are logged in[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:387[0m [36m# ApplicationController delete action logged in does not let a user delete a tweet they did not create[0m
[31mrspec ./spec/controllers/application_controller_spec.rb:408[0m [36m# ApplicationController delete action logged out does not load let user delete a tweet if not logged in[0m

