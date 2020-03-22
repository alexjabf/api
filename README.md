# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
    - 2.6.5
* Configuration
    - set FB_APP_ID
    - set FB_APP_SECRET
* Database creation
    - run db:create db:migrate 
* Database initialization
    - run db:seed
* Deployment instructions
    - rails s
* TODO
    - Fix issue with sing out:
        * "status": 500,
        * "error": "Internal Server Error",
        * "exception": "#<ArgumentError: Before process_action callback :verify_signed_out_user has not been defined>"
    - Fix issue with uploading images:
        * "status": 500,
        * "error": "Internal Server Error",
        * "exception": "#<LoadError: library not found for class Digest::Base64 -- digest/base64>"
# api
