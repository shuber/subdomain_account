module UserTestHelper
  
  def create_user(options = {})
    User.create(valid_user_hash(options))
  end
  
  def valid_user_hash(options = {})
    { :email => 'test@test.com' }.merge(options)
  end
  
end