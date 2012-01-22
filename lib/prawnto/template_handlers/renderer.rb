module Prawnto
  module TemplateHandlers
    class Renderer
      def initialize(calling_object = nil)
        @calling_object = calling_object
        copy_instance_variables_from(@calling_object) if @calling_object
        @pdf = Prawn::Document.new(@prawnto_options[:prawn]);
        self
      end
      
      def to_pdf(&block)
        instance_eval(&block)
        @pdf.render.html_safe
      end
    
    private
    
      def pdf
        @pdf
      end
    
      # This was removed in Rails 3.1
      def copy_instance_variables_from(object, exclude = [])
        vars = object.instance_variables.map(&:to_s) - exclude.map(&:to_s)
        vars.each { |name| instance_variable_set(name, object.instance_variable_get(name)) }
      end
   
      def method_missing(m, *args)
        begin
          super
        rescue
          if pdf.respond_to?(m.to_s)
            pdf.send(m, *args)
          elsif @calling_object.respond_to?(m.to_s)
            @calling_object.send(m, *args)
          else
            raise
          end
        end
      end
  
    end
  end
end
  