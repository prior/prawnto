module Prawnto
  class Railtie < Rails::Railtie

    config.to_prepare do
      puts "running railtie initializer"
      Prawnto.register_handlers
    end
    
    #switching from an initializer to a :to_prepare will run it once in production and before each load in development
    config.to_prepare do
      puts "running railtie includes"
      Prawnto.run_includes
    end
    
  end
end