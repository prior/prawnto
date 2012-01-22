$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'prawnto/railtie' if defined?(Rails)

module Prawnto
  autoload :ActionControllerMixin, 'prawnto/action_controller_mixin'
  autoload :ActionViewMixin, 'prawnto/action_view_mixin'
  module TemplateHandlers
    autoload :CompileSupport, 'prawnto/template_handlers/compile_support'
    autoload :Base, 'prawnto/template_handlers/base'
    autoload :Dsl, 'prawnto/template_handlers/dsl'
  end
end
