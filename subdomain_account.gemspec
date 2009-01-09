Gem::Specification.new do |s| 
  s.name    = 'subdomain_account'
  s.version = '1.0.1'
  s.date    = '2009-01-09'
  
  s.summary     = 'A rails gem/plugin that handles subdomain accounts'
  s.description = 'A rails gem/plugin that handles subdomain accounts'
  
  s.author   = 'Sean Huber'
  s.email    = 'shuber@huberry.com'
  s.homepage = 'http://github.com/shuber/subdomain_account'
  
  s.has_rdoc = false
  s.rdoc_options = ['--line-numbers', '--inline-source', '--main', 'README.markdown']
  
  s.require_paths = ['lib']
  
  s.files = %w(
    CHANGELOG
    init.rb
    lib/subdomain_account.rb
    MIT-LICENSE
    Rakefile
    README.markdown
    test/helpers/account_test_helper.rb
    test/helpers/table_test_helper.rb
    test/helpers/user_test_helper.rb
    test/init.rb
  )
  
  s.test_files = %w(
    test/subdomain_account_test.rb
  )
end