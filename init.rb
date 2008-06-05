require 'huberry/subdomain_account/controller_methods'
require 'huberry/subdomain_account/request_methods'

ActionController::Base.extend Huberry::SubdomainAccount::ControllerMethods
ActionController::AbstractRequest.send :include, Huberry::SubdomainAccount::RequestMethods

$:.unshift File.dirname(__FILE__) + '/lib'