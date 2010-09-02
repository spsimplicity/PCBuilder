# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_PCBuilder_session',
  :secret      => '86999e3493cc82c12de2e6b03a7602ad08b104fa7051ff21008b6e6d1080259d3c194ac99d2599bfd21bde6a6ad2bdfb768443b9f2a290dafafbbad54de1e20a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
