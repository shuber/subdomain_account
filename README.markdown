Huberry::SubdomainAccount
=========================

A rails plugin that handles subdomain accounts


Installation
------------

	script/plugin install git://github.com/shuber/subdomain_account.git


Example
-------

	class ProjectsController < ApplicationController
		before_filter :subdomain_account_required
		
		def index
			render :text => current_account.subdomain
		end
	end


Controller Methods
------------------
	
	# Returns the current account or nil if one is not found
	current_account
	
	# A before filter to require a subdomain - renders a 404 if one is not found (overwrite subdomain_account_not_found to change this behavior)
	subdomain_account_required


Request Methods
---------------

	# Request http://test.example.com:8080/home
	class HomeController < ApplicationController
		def index
			# returns 'example.com:8080'
			request.domain_with_port
	
			# returns 'test.example.com'
			request.host_with_subdomain
			
			# returns 'testing.example.com'
			request.host_with_subdomain('testing')
	
			# returns 'example.com'
			request.host_without_subdomain
	
			returns 'test'
			request.subdomain
		end
	end


Contact
-------

Problems, comments, and suggestions all welcome: [shuber@huberry.com](mailto:shuber@huberry.com)