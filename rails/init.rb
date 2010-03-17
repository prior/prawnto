require 'prawnto'
if defined? Rails && defined? RAILS_ROOT && defined? Prawn
    Prawnto.enable
else
  throw "Should be enabled only if Rails && Prawn are both defined"
end
