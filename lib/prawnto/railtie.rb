if defined?(Rails) && defined?(Rails::Railtie)
  module Prawnto
    class Railtie < Rails::Railtie
      initializer 'prawnto.init_config' do
        Prawnto.enable
      end
    end
  end
end