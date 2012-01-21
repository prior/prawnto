require "prawnto/action_controller_mixins/options_manager"
require "prawnto/action_controller_mixins/header_methods"

module Prawnto
  module ActionControllerMixin
    def self.included(base)
      base.class_eval do
        include HeaderMethods
        include OptionsManager
      end
    end
  end
end


