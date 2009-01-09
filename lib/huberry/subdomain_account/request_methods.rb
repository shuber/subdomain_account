module Huberry
  module SubdomainAccount
    module RequestMethods
      def domain_with_port(tld_length = 1)
        domain(tld_length) + port_string
      end
      
      def host_with_subdomain(sub = subdomain, tld_length = 1)
        result = sub.nil? ? '' : "#{sub}."
        result << domain_with_port(tld_length)
      end
      
      def host_without_subdomain
        parts = host.split('.')
        parts.delete_at(0) if parts.size > 2
        parts.join('.')
      end
      
      def subdomain
        subdomains.first
      end
    end
  end
end