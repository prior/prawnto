module Prawnto
  module ActionControllerMixin
    DEFAULT_PRAWNTO_OPTIONS = {:inline=>true}
  
    def self.included(base)
      base.send :attr_reader, :prawnto_options
      base.class_attribute :prawn_hash, :prawnto_hash
      base.prawn_hash = {}
      base.prawnto_hash = {}
      base.extend ClassMethods
    end

    module ClassMethods
    
      # This is the class setter. It lets you set default options for all prawn actions within a controller.
      def prawnto(options)
        prawn_options, prawnto_options = breakdown_prawnto_options options
        self.prawn_hash = prawn_options
        self.prawnto_hash = DEFAULT_PRAWNTO_OPTIONS.dup.merge(prawnto_options)
      end
  
      private

      # splits the :prawn key out into a seperate hash
      def breakdown_prawnto_options(options)
        prawnto_options = options.dup
        prawn_options = (prawnto_options.delete(:prawn) || {}).dup
        [prawn_options, prawnto_options]
      end
    end
  
    # Sets the prawn options. Use in the controller method.
    #
    # respond_to {|format|
    #   format.pdf { prawnto(:page_orientation => :landscape) }
    # }
    def prawnto(options)
      @prawnto_options ||= {}
      @prawnto_options.merge! options
    end

  private

    # this merges the default prawnto options, the controller prawnto options, and the instance prawnto options, and the splits out then joins in the :prawn options.
    # This is called when setting the header information just before render.
    def compute_prawnto_options
      @prawnto_options ||= DEFAULT_PRAWNTO_OPTIONS.dup
      @prawnto_options[:prawn] ||= {}
      @prawnto_options[:prawn].merge!(self.class.prawn_hash || {}) {|k,o,n| o}
      @prawnto_options.merge!(self.class.prawnto_hash || {}) {|k,o,n| o}
      @prawnto_options
    end
  end
end


