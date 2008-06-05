module Huberry
	module SubdomainAccount
		module RequestMethods
			def domain_with_port(tld_length = 1)
				@domain_with_port ||= domain(tld_length) + port_string
			end
			
			def subdomain
				subdomains.first
			end
		end
	end
end