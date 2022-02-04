# frozen_string_literal: true

require 'pry-rails/railtie'

module Helium
  class Console
    module Rails
      class Railtie < ::Rails::Railtie
        console do
          Helium::Console::Rails.load!
          ::Rails.application.config.console = ::Helium::Console
        end
      end
    end
  end
end
