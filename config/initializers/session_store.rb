# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_devcsun_session',
  :secret      => 'e9a3a24131aa8bb05a04ac13ad4884802e80f08f93f184af9c898043d5d51e1aff2f4d4359354e4d058ed5668a8b571e821906a37aa9d3c07e1d0c96400921b3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
