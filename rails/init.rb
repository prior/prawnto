require 'prawnto'
if defined?(Rails) && defined?(Rails.root) && defined?(Prawn)
    Prawnto.enable
end
