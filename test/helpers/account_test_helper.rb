module UserTestHelper
  
  def create_account(options = {})
    Account.create(valid_account_hash(options))
  end
  
  def valid_account_hash(options = {})
    { :subdomain => 'test' }.merge(options)
  end
  
end