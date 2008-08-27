module Prawnto
  module ActionController
      
    def self.included(base)
      base.extend ClassMethods
      base.before_filter :reset_prawnto_options
    end

    module ClassMethods
      def prawnto(options)
        prawn_options, prawnto_options = breakdown_prawnto_options options
        write_inheritable_hash(:prawn, prawn_options)
        write_inheritable_hash(:prawnto, prawnto_options)
      end
    
    private

      def breakdown_prawnto_options(options)
        prawnto_options = options.dup
        prawn_options = (prawnto_options.delete(:prawn) || {}).dup
        [prawn_options, prawnto_options]
      end
    end

    def prawnto(options)
      @prawnto_options.merge! options
    end


  private

    def reset_prawnto_options
      @prawnto_options = {:inline=> true}
    end

    def compute_prawnto_options
      @prawnto_options ||= reset_prawnto_options
      @prawnto_options[:prawn] ||= {}
      @prawnto_options[:prawn].merge!(self.class.read_inheritable_attribute(:prawn) || {}) {|k,o,n| o}
      @prawnto_options.merge!(self.class.read_inheritable_attribute(:prawnto) || {}) {|k,o,n| o}
      @prawnto_options
    end

  end
end


