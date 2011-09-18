module Prawnto
  module ActionViewMixin

    private

    def _prawnto_compile_setup
      controller.set_headers
      @prawnto_options = controller.prawnto_options
    end

  end
end

