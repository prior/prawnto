module Prawnto
  module ModelRenderer
    
    class CustomController < ApplicationController
      def initialize
        super
        self.request = ActionDispatch::Request.new({})
        self.response = ActionDispatch::Response.new()
        self.params = {:format => :pdf}
      end
    end
    
    # template : invoices/show.pdf
    # instance_variables : {"@account" => account} - variables set in before filters
    def self.to_string(template, calling_object = nil)
      instance = CustomController.new

      if calling_object
        instance.prawnto :inline => true, :instance_variables_from => calling_object
      end
  
      return instance.render_to_string(:action => template, :template => false, :formats => [:pdf]).html_safe
    end

  end
end