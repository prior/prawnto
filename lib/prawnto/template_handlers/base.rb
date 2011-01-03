module Prawnto
  module TemplateHandlers
    class Base < ::ActionView::TemplateHandler
      include ::ActionView::TemplateHandlers::Compilable
      
      def compile(template)
        "pdf = @pdf; #{template.source}"
      end
    end
  end
end


