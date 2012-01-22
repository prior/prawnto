module Prawnto
  module ActionViewMixins
    class CompileSupport
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
        unless defined?(ActionMailer) && defined?(ActionMailer::Base) && @controller.is_a?(ActionMailer::Base)
          set_pragma
          set_cache_control
          set_content_type
          set_disposition
          set_other_headers_for_ie_ssl
        end
      end

      def ie_request?
        @controller.request.env['HTTP_USER_AGENT'] =~ /msie/i
      end

      def ssl_request?
        @controller.request.ssl?
      end
      
      def set_other_headers_for_ie_ssl
        return unless ssl_request? && ie_request?
        headers['Content-Description'] = 'File Transfer'
        headers['Content-Transfer-Encoding'] = 'binary'
        headers['Expires'] = '0'        
      end

      # TODO: kept around from railspdf-- maybe not needed anymore? should check.
      def set_pragma
        if ssl_request? && ie_request?
          @controller.headers['Pragma'] = 'public' # added to make ie ssl pdfs work (per naisayer)
        else
          @controller.headers['Pragma'] ||= ie_request? ? 'no-cache' : ''
        end
      end

      # TODO: kept around from railspdf-- maybe not needed anymore? should check.
      def set_cache_control
        if ssl_request? && ie_request?
          @controller.headers['Cache-Control'] = 'maxage=1' # added to make ie ssl pdfs work (per naisayer)
        else
          @controller.headers['Cache-Control'] ||= ie_request? ? 'no-cache, must-revalidate' : ''
        end
      end

      def set_content_type
        @controller.response.content_type ||= Mime::PDF
      end

      def set_disposition
        inline = options[:inline] ? 'inline' : 'attachment'
        filename = options[:filename] ? "filename=\"#{options[:filename]}\"" : nil
        @controller.headers["Content-Disposition"] = [inline,filename].compact.join(';')
      end

    end
  end
end



