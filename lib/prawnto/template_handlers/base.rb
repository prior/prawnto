module Prawnto
  module TemplateHandlers
    class Base
      def self.call(template)
        new.call(template)
      end

      def call(template)
        "_prawnto_compile_setup;" +
        "pdf = Prawn::Document.new(@prawnto_options[:prawn]);" +
        "#{template.source}\n" +
        "raw pdf.render;"
      end
    end
  end
end


