module Prawnto
  module TemplateHandlers
    class Base < (::Rails::VERSION::MAJOR < 3 ? ::ActionView::TemplateHandler : ::Object)
      include ::ActionView::TemplateHandlers::Compilable if ::Rails::VERSION::MAJOR < 3
      
      def compile(template)
        "_prawnto_compile_setup;" +
        "pdf = Prawn::Document.new(@prawnto_options[:prawn]);" + 
        "#{template.source}\n" +
        "pdf.render;"
      end
    end
  end
end


