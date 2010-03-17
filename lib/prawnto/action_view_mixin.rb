module Prawnto
  module ActionViewMixin

  private
    def _prawnto_compile_setup(dsl_setup = false)
      compile_support = Prawnto::TemplateHandler::CompileSupport.new(controller)
      @prawnto_options = compile_support.options
    end

  end
end

