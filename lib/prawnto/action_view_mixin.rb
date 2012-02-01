module Prawnto
  module ActionViewMixin

  private

    def _prawnto_compile_setup
      compile_support = CompileSupport.new(controller)
      @prawnto_options = compile_support.options
    end

  end
end

