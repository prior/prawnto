module Prawnto
  class Railtie < Rails::Railtie

    # This runs once during initialization.
    initializer "prawnto.register_handlers" do
      Prawnto.register_handlers
    end
    
    # This will run it once in production and before each load in development.
    config.to_prepare do
      Prawnto.run_includes
    end
    
  end
end