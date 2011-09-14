module TemplateHandlerTestMocks
    # 
    # class Template
    #   attr_reader :source, :locals, :filename
    # 
    #   def initialize(source, locals={})
    #     @source = source
    #     @locals = locals
    #     @filename = "blah.pdf"
    #   end
    # end
    # 
  
  
  class Request
    def env
      {}
    end
    
    def ssl?
      false
    end
  end
  
  class ActionController
    include Prawnto::ActionControllerMixin
  
    def response
      @response ||= ActionDispatch::TestResponse.new
    end
  
    def request
      @request ||= Request.new
    end
  
    def headers
      response.headers
    end
  end
    
  class ActionView
    include Prawnto::ActionViewMixin

    def controller
      @controller ||= ActionController.new
    end
    
    def response
      controller.response
    end
    
    def request
      controller.request
    end
    
    def headers
      controller.headers
    end
    
    def prawnto_options
      controller.get_instance_variable(:@prawnto_options)
    end
    
    def public_prawnto_compile_setup
      _prawnto_compile_setup
    end
    
  end


end

