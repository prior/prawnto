require 'prawn'
require 'prawnto/action_controller'
require 'prawnto/template_handler'


# for now applying to all Controllers
# however, could reduce footprint by letting user mixin (i.e. include) only into controllers that need it
# but would does it really matter performance wise to include in a controller that doesn't need it?  doubtful.
class ActionController::Base
  include Prawnto::ActionController
end

