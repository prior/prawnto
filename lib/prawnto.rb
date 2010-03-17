$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Prawnto
  autoload :ActionControllerMixin, 'prawnto/action_controller_mixin'
  autoload :ActionViewMixin, 'prawnto/action_view_mixin'
  module TemplateHandlers
    autoload :Base, 'prawnto/template_handlers/base'
    autoload :Dsl, 'prawnto/template_handlers/dsl'
    autoload :Raw, 'prawnto/template_handlers/raw'
  end

  module TemplateHandler
    autoload :CompileSupport, 'prawnto/template_handler/compile_support'
  end

  class << self
    def enable
      ActionController::Base.send :include, Prawnto::ActionControllerMixin
      ActionView::Base.send :include, Prawnto::ActionViewMixin
      Mime::Type.register "application/pdf", :pdf
      ActionView::Template.register_template_handler 'prawn', Prawnto::TemplateHandlers::Base
      ActionView::Template.register_template_handler 'prawn_dsl', Prawnto::TemplateHandlers::Dsl
      ActionView::Template.register_template_handler 'prawn_xxx', Prawnto::TemplateHandlers::Raw  
    end
  end
end

