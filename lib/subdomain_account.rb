module Huberry
  module SubdomainAccount
    def self.extended(base)
      base.class_eval do
        include InstanceMethods
        include AuthenticationPatch if included_modules.collect(&:to_s).include? 'Huberry::Authentication::ControllerMethods::InstanceMethods'
        
        cattr_accessor :subdomain_account_options
        self.subdomain_account_options = {
          :model => 'Account',
          :field => :subdomain
        }
        
        attr_accessor :current_account
        helper_method :current_account
      end
    end
    
    module InstanceMethods
      protected
        def find_current_account(force_query = false)
          if @queried_for_current_account.nil? || force_query
            account_class = self.class.subdomain_account_options[:model].to_s.constantize
            self.current_account = account_class.send "find_by_#{self.class.subdomain_account_options[:field]}", request.subdomains.first
          end
          self.current_account
        end
        
        def subdomain_account_not_found
          respond_to do |format|
            format.html { render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 }
            format.all { render :nothing => true, :status => 404 }
          end
        end
        
        def subdomain_account_required
          subdomain_account_not_found if find_current_account.nil?
        end
    end
    
    module AuthenticationPatch
      protected
        def find_current_user(force_query = false)
          if @queried_for_current_user.nil? || force_query
            @queried_for_current_user = true
            underscored_authentication_model = self.class.authentication_model.to_s.underscore
            self.current_user = find_current_account.send(underscored_authentication_model.pluralize.to_sym).find(session["#{underscored_authentication_model}_id".to_sym]) rescue nil
          end
          self.current_user
        end
    end
  end
end

ActionController::Base.extend Huberry::SubdomainAccount