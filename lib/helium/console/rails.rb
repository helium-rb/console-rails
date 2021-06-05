require "helium/console"
require "helium/console/rails/version"
require "helium/console/rails/railtie"

module Helium
  class Console
    module Rails
      def self.load!
        Dir.glob(File.join(File.dirname(__FILE__), "rails", "registry", "**/*.rb")).each do |file|
          require file
        end
      end
    end
  end
end
