# Load the rails application
require File.expand_path('../application', __FILE__)


# Initialize the rails application
DocumentManagementFinal::Application.initialize!

config.action_mailer.default_url_options = { :host => 'http://sheltered-shelf-2154.herokuapp.com' }