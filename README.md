# README

Project requirements:

* Ruby 2.5.5
* Rails 5.2.3
* PostgreSQL 9.4 or higher
* RVM
* Angular

## Database

Important: Create 'database.yml' and configure the PostgreSQL credentials (User and Password).
Run the commands: `rails db:create && rails db:migrate`

There is a small backup from the heroku web app contained in the database folder, inside
misc-resources, if you want to use it, you must skip the rails `db:migrate` command and make
a restore instead.

## Credentials

To configure credentials for Amazon S3 service, type the command: `EDITOR=nano rails credentials:edit`
Inside we modify with the credentials of an configured access key and the secrete base key,
the estructure must be like this:

aws:
  access_key_id: 'KEYID'
  secret_access_key: 'SECRETKEY'

secret_key_base: AVERYLONGKEY


Also make sure to modify the file storage.yml

## Test users for API (In heroku app)

User account
oscar.nunez1908@yahoo.com
test616

Admin account
ojnc.190888@gmail.com
admin-616

## API Postman resources

In the folder `misc-resources/postman` includes two json files which we can import them from the Postman App

Collection requests:
  /misc-resources/postman/Movie Rental Store.postman_collection.json

Enviroments vars to use in the collection requests:
  /misc-resources/postman/Snacks store API.postman_environment.json

Final URL is: https://space-movie-rental-store.herokuapp.com

## Frontend integration with Angular

To run the backend locally, type the command `rails s`, it will run on the default `localhost:3000`

The angular project it's integrated on the frontend folder, type the command `npm install` on a console inside the project
and then `ng serve`

// Only shows the list of movies
