module Prawnto
  module TemplateHandler

    class CompileSupport
      extend ActiveSupport::Memoizable
      
      attr_reader :options

      def initialize(controller)
        @controller = controller
        @options = pull_options
        set_headers
      end

      def pull_options
        @controller.send :compute_prawnto_options || {}
      end

      def set_headers
        set_pragma
        set_cache_control
        set_content_type
        set_disposition
      end

      # TODO: kept around from railspdf-- maybe not needed anymore? should check.
      def ie_request?
        @controller.request.env['HTTP_USER_AGENT'] =~ /msie/i
      end
      memoize :ie_request?

      # TODO: kept around from railspdf-- maybe not needed anymore? should check.
      def set_pragma
        @controller.headers['Pragma'] ||= ie_request? ? 'no-cache' : ''
      end

      # TODO: kept around from railspdf-- maybe not needed anymore? should check.
      def set_cache_control
        @controller.headers['Cache-Control'] ||= ie_request? ? 'no-cache, must-revalidate' : ''
      end

      def set_content_type
        @controller.response.content_type ||= Mime::PDF
      end

      def set_disposition
        inline = options[:inline] ? 'inline' : 'attachment'
        filename = options[:filename] ? "filename=#{options[:filename]}" : nil
        @controller.headers["Content-Disposition"] = [inline,filename].compact.join(';')
      end

    end

  end
end



