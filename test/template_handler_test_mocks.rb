module TemplateHandlerTestMocks

  class Template
    attr_reader :source

    def initialize(source)
      @source = source
    end
  end


  class Response
    def headers
      {}
    end

    def content_type=(value)
    end
  end

  class Request
    def env
      {}
    end
  end

  class ActionController
    attr_reader :prawnto_options

    def initialize
      @prawnto_options = {:prawn=>{}}
    end
    
    def compute_prawnto_options
      @prawnto_options
    end

    def response
      @response ||= Response.new
    end

    def request
      @request ||= Request.new
    end
  end
    
  class ActionView
    def controller
      @controller ||= ActionController.new
    end

    def response
      controller.response
    end

    def request
      controller.request
    end

    def prawnto_options
      controller.prawnto_options
    end
  end


end

