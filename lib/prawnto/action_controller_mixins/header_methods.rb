module Prawnto
  module ActionControllerMixin
    module HeaderMethods

      
      def set_headers
        compute_prawnto_options
    
        unless defined?(ActionMailer) && defined?(ActionMailer::Base) && self.is_a?(ActionMailer::Base)
          set_pragma
          set_cache_control
          set_content_type
          set_disposition
          set_other_headers_for_ie_ssl
        end
      end

      private

      # TODO: kept around from railspdf-- maybe not needed anymore? should check.
      def ie_request?
        request.env['HTTP_USER_AGENT'] =~ /msie/i
      end
      # memoize :ie_request?

      # added to make ie happy with ssl pdf's (per naisayer)
      def ssl_request?
    		request.ssl?
      end
      # memoize :ssl_request?

      def set_other_headers_for_ie_ssl
        return unless ssl_request? && ie_request?
        headers['Content-Description'] = 'File Transfer'
        headers['Content-Transfer-Encoding'] = 'binary'
        headers['Expires'] = '0'        
      end

      # TODO: kept around from railspdf-- maybe not needed anymore? should check.
      def set_pragma
        if ssl_request? && ie_request?
          headers['Pragma'] = 'public' # added to make ie ssl pdfs work (per naisayer)
        else
          headers['Pragma'] ||= ie_request? ? 'no-cache' : ''
        end
      end

      # TODO: kept around from railspdf-- maybe not needed anymore? should check.
      def set_cache_control
        if ssl_request? && ie_request?
          headers['Cache-Control'] = 'maxage=1' # added to make ie ssl pdfs work (per naisayer)
        else
          headers['Cache-Control'] ||= ie_request? ? 'no-cache, must-revalidate' : ''
        end
      end

      def set_content_type
        response.content_type ||= Mime::PDF
      end

      def set_disposition
        inline = @prawnto_options[:inline] ? 'inline' : 'attachment'
        filename = @prawnto_options[:filename] ? "filename=\"#{@prawnto_options[:filename]}\"" : nil
        headers["Content-Disposition"] = [inline,filename].compact.join(';')
      end
    end
  end
end