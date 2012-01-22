$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'prawnto/railtie' if defined?(Rails)

module Prawnto
  autoload :ActionControllerMixin, 'prawnto/action_controller_mixin'
  
  module ActionViewMixins
    autoload :ActionViewMixin, 'prawnto/action_view_mixins/action_view_mixin'
    autoload :CompileSupport, 'prawnto/action_view_mixins/compile_support'
  end

  module TemplateHandlers
    autoload :Renderer, 'prawnto/template_handlers/renderer'
    
    autoload :Base, 'prawnto/template_handlers/base'
    autoload :Dsl, 'prawnto/template_handlers/dsl'
  end
  
  autoload :ModelRenderer, 'prawnto/model_renderer'
  
end
