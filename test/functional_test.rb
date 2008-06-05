require File.dirname(__FILE__) + '/init'

class Account < ActiveRecord::Base
	has_many :users
end

class User < ActiveRecord::Base
	belongs_to :account
end

class TestController < ActionController::Base
	before_filter :subdomain_account_required, :only => :account_required
	
	def account_required
		render :text => 'test'
	end
	
	def account_not_required
		render :text => 'test'
	end
	
	def rescue_action(e)
		raise e
	end
end

ActionController::Routing::Routes.append do |map|
	map.connect 'account_required', :controller => 'test', :action => 'account_required', :format => 'xml'
	map.connect 'account_not_required', :controller => 'test', :action => 'account_not_required'
end

class FunctionalTest < Test::Unit::TestCase
	
	def setup
		create_accounts_table
    create_users_table

		@account = create_account
		@user = @account.users.create(valid_user_hash)

		@controller = TestController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

		@controller.instance_variable_set('@_session', @request.session)
  end
  
  def teardown
    drop_all_tables
  end

	def test_should_get_account_required
		@request.host = "#{@account.subdomain}.localhost.com"
		get :account_required, :format => 'xml'
		assert_response :success
	end

	def test_should_get_account_not_required
		get :account_not_required
		assert_response :success
	end

	def test_should_render_404_if_account_not_found
		@request.host = 'localhost.com'
		get :account_required, :format => 'xml'
		assert_response :not_found
		
		@request.host = 'invalid.localhost.com'
		get :account_required, :format => 'xml'
		assert_response :not_found
	end
	
end