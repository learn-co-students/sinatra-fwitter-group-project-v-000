what's the difference between #find and #find_by_#whatever? When is it necessary to differentiate?

End of 12/4/18 11:47pm
okay so I CAN'T edit other peoples tweets, and you can't edit your own tweets! haha I'm just seeing all tweets, but not who wrote them, Im not sure where each user's individual page is at, and when I just go there via the URL users/:slug (so at this point I'm just typing in manually what I know the slug to be) there are no tweets showing up, and it says @user is nil in pry.

SO I have some things to do tomorrow! Lol.
But! Got a LOT done with my tweetscontroller with added in conditional logic for logged_in?, which I wasn't sure about before so that's awesome.

some helpful labs to have open while working:
-secure password lab
-nyc sinatra
-playlister sinatra


unrelated but helpful!: BASH COMMAND SHORTCUTS
- cd (start typing the child directory you want) and hit |tab| and it'll autocomplete the subdirectory for you
- "cd -" will go back to whatever directory you were in before (unlike "cd .." which just move "up" one directory)
-rm sandbox will delete the sandbox (or whatever file you want deleted within the directory you're in)



okay great so all errors are done, and technically everythings working. User experience is garbage though so that'll be my focus after lunch!



okay so things (besides stlying) that I want to do:

√ 1.  I need to figure out why @user is not saving the tweets and why there's no connection to /users/:slug, and where it could be useful
X 2. I want the edit and delete buttons to not appear if it's not your tweet, not just redirect to the show page
X 3. I need to figure out how to eliminate empty tweets
√ 4. Add time created (look up strftime/how to implement that=> look at howards code from the journal app)
√ 5. Add a user/slug link to your tweets page so a person can go to their personal page
√ 6. Add a new tweet link to the tweets page
  7. Figure out why my flash messages are broken (howards code will answer this as well)


I can't figure out how to get the tweets page to display the user who wrote each tweet, because in my @tweets array of tweet objects I have user_id, but I can't remember how to access the username through this association.

.uniq in the iteration works for not repeating the same tweet on the page, but I need a ruby method that eliminates empty tweets, although I have functionality in my tweets post controller that doesn't let someone write a empty tweet, so this is less important now.

I'd say finish with flash messages and strftime solutions and this is ready to ship
