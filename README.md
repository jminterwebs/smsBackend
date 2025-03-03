# README


 SMS messenger app. 
 
- uses atlas and mongodb as db
- user authentication
- twilio for text messaging

### Setup

    1. ASDF for version control on ruby 3.3.7.
    2. Install gems with `bundle install`
    3. rails s

Frontend repo:
[here](https://github.com/jminterwebs/smsFrontend)


ENV variables needed:

    - TWILIO_SID : twilio acount sid
    - TWILIO_AUTH_TOKEN : twilio auth token
    - MONGODB_URI : atlas mongodb uri