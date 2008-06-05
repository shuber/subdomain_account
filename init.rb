require 'huberry/subdomain_account/controller_methods'

ActionController::Base.extend Huberry::SubdomainAccount::ControllerMethods

$:.unshift File.dirname(__FILE__) + '/lib'