subdomain\_account
==================

A rails plugin that handles subdomain accounts


Installation
------------

	script/plugin install git://github.com/shuber/subdomain_account.git


Usage
-----

Simply add `before_filter :subdomain_account_required` for any actions that require a subdomain. A `:model` will then be searched 
by `:field` for the current subdomain. The result of that query is stored in a controller instance method called `current_account`. 
In the example below, the `current_account` would be set to the result of `Account.find_by_subdomain(request.subdomains.first)`. 
The `:model` and `:field` options are customizable, see below.

	class ProjectsController < ApplicationController
	  before_filter :subdomain_account_required
	
	  def index
	    render :text => current_account.subdomain
	  end
	end

By default the `:model` to use for looking up records is `Account` and the `:field` to search by is `:subdomain`. You can change 
this by modifying the controller's `subdomain_account_options` attribute like so:

	class ApplicationController < ActionController::Base
	  self.subdomain_account_options.merge!(:model => Company, :field => :username)
	end

When a subdomain is required but the `current_account` was not found, the controller calls the `subdomain_account_not_found` instance 
method which simply renders a 404. You can overwrite this method to change this behavior.


Contact
-------

Problems, comments, and suggestions all welcome: [shuber@huberry.com](mailto:shuber@huberry.com)