# designed as a helper to automatically increment the trusted host

module EAS
  module Helpers
    def getTrustedHostName
      node["fqdn"]
    end
  end
end