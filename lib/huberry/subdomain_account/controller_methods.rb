module Huberry
  module SubdomainAccount
    module ControllerMethods
      def self.extended(base)
        base.class_eval do
          include InstanceMethods
          include AuthenticationPatch if included_modules.collect(&:to_s).include? 'Huberry::Authentication::ControllerMethods::InstanceMethods'
          
          cattr_accessor :subdomain_account_model, :subdomain_field
          self.subdomain_account_model = 'Account'
          self.subdomain_field = :subdomain
          
          attr_accessor :current_account
          helper_method :current_account
        end
      end
      
      module InstanceMethods
        protected
          def find_current_account(force_query = false)
            if @queried_for_current_account.nil? || force_query
              account_class = self.class.subdomain_account_model.to_s.constantize
              self.current_account = account_class.send "find_by_#{self.class.subdomain_field}", request.subdomain
            end
            self.current_account
          end
          
          def subdomain_account_not_found
            respond_to do |format|
              format.html { render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 }
              format.all { render :nothing => true, :status => 404 }
            end
            false
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
              users = self.class.authentication_model.to_s.underscore.pluralize
              self.current_user = find_current_account.send(users).find(session[:user_id]) rescue nil
            end
            self.current_user
          end
      end
    end
  end
end