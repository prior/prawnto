require "prawn"

module Prawnto
  module TemplateHandlers
    class Base
      def self.call(template)
        check_for_pdf_redefine(template.source)

        "_prawnto_compile_setup;" +
        "renderer = Prawnto::TemplateHandlers::Renderer.new(self);"+
        "renderer.to_pdf do; #{template.source}\nend;"
      end

    private

      def self.check_for_pdf_redefine(template_source)
        if template_source =~ /pdf\s*=[^=]/
          Rails.logger.debug "\nPrawnto Warning! It looks like you may be redefining 'pdf' in your .prawn template. This no longer works in Prawnto 2+. Please use the :prawnto method in your controller\n"
        end
      end
    end
  end
end


