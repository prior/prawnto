module Prawnto
  module ActionControllerMixin

    DEFAULT_PRAWNTO_OPTIONS = {:inline=>true}
      
    def self.included(base)
      base.class_attribute :prawn_hash, :prawnto_hash
      base.prawn_hash = {}
      base.prawnto_hash = {}
      base.extend ClassMethods
    end

    module ClassMethods
      
      # Sets options in the class attributes. Can be pulled into the instance variable with :compute_prawnto_options
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


    # Sets options directly on the instance
    def prawnto(options)
      @prawnto_options ||= {}
      @prawnto_options.merge! options
    end


  private

    # Used to set the @prawnto_options variable before rendering. Called from compile_support just before rendering.
    def compute_prawnto_options
      @prawnto_options ||= DEFAULT_PRAWNTO_OPTIONS.dup
      @prawnto_options[:prawn] ||= {}
      @prawnto_options[:prawn].merge!(self.class.prawn_hash || {}) {|k,o,n| o}
      @prawnto_options.merge!(self.class.prawnto_hash || {}) {|k,o,n| o}
      @prawnto_options
    end

  end
end


