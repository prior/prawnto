module Prawnto
  module ActionController

    DEFAULT_PRAWNTO_OPTIONS = {:inline=>true}
    extend ActiveSupport::Concern

    included do
      self.class_attribute :prawnto_options
      self.class_attribute :prawn_options
    end

    module ClassMethods
      def prawnto(options)
        self.prawn_options, self.prawnto_options = breakdown_prawnto_options options
      end

    private

      def breakdown_prawnto_options(options)
        prawnto_options = options.dup
        prawn_options = (prawnto_options.delete(:prawn) || {}).dup
        [prawn_options, prawnto_options]
      end
    end

    module InstanceMethods
      def prawnto(options)
        @prawnto_options ||= DEFAULT_PRAWNTO_OPTIONS.dup
        @prawnto_options.merge! options
      end


    private

      def compute_prawnto_options
        @prawnto_options ||= DEFAULT_PRAWNTO_OPTIONS.dup
        @prawnto_options[:prawn] ||= {}
        @prawnto_options[:prawn].merge!(prawn_options || {}) {|k,o,n| o}
        @prawnto_options.merge!(prawnto_options|| {}) {|k,o,n| o}
        @prawnto_options
      end
    end

  end
end


