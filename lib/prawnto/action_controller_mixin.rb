module Prawnto
  module ActionControllerMixin

    DEFAULT_PRAWNTO_OPTIONS = {:inline=>true}
      
    def self.included(base)
      base.class_attribute :prawn, :prawnto
      base.extend ClassMethods
    end

    module ClassMethods
      def prawnto(options)
        self.class.prawn, self.class.prawnto = breakdown_prawnto_options(options)
      end
    
    private

      def breakdown_prawnto_options(options)
        prawnto_options = options.dup
        prawn_options = (prawnto_options.delete(:prawn) || {}).dup
        [prawn_options, prawnto_options]
      end
    end

    def prawnto(options)
      @prawnto_options ||= DEFAULT_PRAWNTO_OPTIONS.dup
      @prawnto_options.merge! options
    end


  private

    def compute_prawnto_options
      @prawnto_options ||= DEFAULT_PRAWNTO_OPTIONS.dup
      @prawnto_options[:prawn] ||= {}
      @prawnto_options[:prawn].merge!(self.class.prawn || {}) {|k,o,n| o}
      @prawnto_options.merge!(self.class.prawnto || {}) {|k,o,n| o}
      @prawnto_options
    end

  end
end


