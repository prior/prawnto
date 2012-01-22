module Prawnto
  module ModelRenderer
    # template : invoices/show.pdf
    # instance_variables : {"@account" => account} - variables set in before filters
    def self.to_string(template, calling_object = nil)
      instance = ApplicationController.new
      instance.request = ActionDispatch::Request.new({})
      instance.response = ActionDispatch::Response.new()
  
      if calling_object
        instance.prawnto :inline => true, :instance_variables_from => calling_object
      end
  
      return instance.render_to_string(template, :template => false).html_safe
    end
  end
end