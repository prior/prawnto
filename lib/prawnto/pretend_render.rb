module Prawnto
  module Render
    # template : invoices/show.pdf
    # instance_variables : {"@account" => account} - variables set in before filters
    def self.to_string(template, calling_object = nil)
      instance = ApplicationController.new
  
      instance.request = ActionDispatch::Request.new({})
      instance.response = ActionDispatch::Response.new()
  
      instance_variables.each{|key, value|
        instance.instance_variable_set(key, value)
      }
  
      return instance.render_to_string(template, :template => false).html_safe
    end
  end
end