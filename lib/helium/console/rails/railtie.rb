module Helium::Console::Rails
  class Railtie < Rails::Railtie
    initializer "helium.console" do
      Helium::Console::Rails.load!
    end
  end
end
