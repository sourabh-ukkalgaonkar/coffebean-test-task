# README

## Assumption and Understanding

While working on the test task I have take few assumption that are as follows.

* As the it `iterable.com` is not providing any api to use without purchase. I have created an mock API using the wiremock. Application uses the `https://gydqr.wiremockapi.cloud` mock API.

* As per the task decscription once user click `on Event B` an email gets trigger by the iterable. So for this I have created my own email that will trigger after succesfully fetching data from the mock API.

* I have tried to write test cases using the https://github.com/cheezy/service_mock an wrapper for wiremock but that is not working properly for me hence I have used the `VCR` gem for mocking purpose.

This documentation will help developer to setup the application on their local env.

## Application Setup

* Run Bundle Install

```sh
	bundle install
```

* Configure local database credentials, I have added the `config/database.yml.example` for example purpose. You have to rename the `config/database.yml.example` to ``config/database.yml`.	You can check the <a href='https://www.freshworks.com/eng-blogs/managing-rails-application-secrets-with-encrypted-credentials-blog/'>blog</a> for more info. You have 

```sh

development:
  database_name: Your Database Name
  database_host: Your Database Host
  database_username: Your Database Username
  database_password: Your Database Password
  database_port: Your Databse Port    

```

* After your local database credential setup. Create the database and run the migration command.

```sh
	# Create Database
	rake db:create

	# Run Migration
	rake db:migrate
``` 

* Generate the seed data

```sh
	# generate the seed data

	rake db:seed
```

* After running the `rake db:seed` some users and projects are created into the system. You can login into the system by using the <b>email</b> : `tester@yopmail.com` and <b>password</b> : `Test@123` .

* You can use the following url `https://gydqr.wiremockapi.cloud`. I have created an mockup API at the wiremock that will be available till 30 days.


	* Curl request to tack an event.	
	
	```
	curl --location --request POST 'https://gydqr.wiremockapi.cloud/api/events/track' \
	--header 'X-WM-Proxy-Url: sadf' \
	--data-raw '{
	  "email": "sourabh.ukkalgaonkar@gmail.com",
	  "eventName": "emailOpen"
	}'
	```

	* Curl request to fetch user's event.

	```
	curl --location --request GET 'https://gydqr.wiremockapi.cloud/api/events/sourabh.ukkalgaonkar@gmail.com' \
--header 'Content-Type: application/json'
	```