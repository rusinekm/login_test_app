# README

Idea is to show how to test user login without using extra gems like devise. I did use Bcrypt Engine, not to cover the actual hashing of password

Unlike normally I also added salt as a column, as knowing what extra characters are added to password should not in fact make it easier to pass through existing rainbow tables. It does make it easier to brute force them, so I'd otherwise create it otherwise (still existing gems do that for you), but this shows better how in fact hashing is done and why salt is added (try hashing 2x same password with different salt and see the results)

distinction between incorect login and password is made purely for academic pursposes. Ideally there shou;ldn't be any additional information presented to person that tries to login if account exists or not (including if has been blocked, as it indicates that it exists)


* Ruby version
3.0.2

* Database creation
run rake db:create
and  add a user via console
or use seeds and run
rake db:setup
to create user "test"/"password"
