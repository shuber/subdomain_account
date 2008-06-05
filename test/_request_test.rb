require File.dirname(__FILE__) + '/init'

class TestController < ActionController::Base
	
	def index
		render :text => 'test'
	end
	
	def rescue_action(e)
		raise e
	end
end

ActionController::Routing::Routes.append do |map|
	map.connect 'index', :controller => 'test'
end

class RequestTest < Test::Unit::TestCase
	
	def setup
		@controller = TestController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

		@request.host = 'test.localhost.com'

		@controller.instance_variable_set('@_request', @request)
		@controller.instance_variable_set('@_session', @request.session)
  end
	
	def test_domain_with_port_with_no_port
		assert_equal 'localhost.com', @controller.request.domain_with_port
	end
	
	def test_domain_with_port_with_non_default_port
		@request.host = 'test.localhost.com'
		@request.port = '8080'
		assert_equal 'localhost.com:8080', @controller.request.domain_with_port
	end
	
	def test_domain_with_port_with_default_port
		@request.host = 'test.localhost.com'
		@request.port = '80'
		assert_equal 'localhost.com', @controller.request.domain_with_port
	end
	
	def test_subdomain_with_subdomain
		assert_equal @controller.request.subdomains.first, @controller.request.subdomain
	end
	
	def test_subdomain_without_subdomain
		@request.host = 'localhost.com'
		assert_nil @controller.request.subdomain
	end
	
end