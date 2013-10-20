module Sinatra
  module Extension
    module Pjax
      def self.registered app
        app.helpers do
          def haml_pjax view
            if is_pjax?
              haml view, :layout => false
            else
              haml view
            end
          end
          def is_pjax?
            @env["HTTP_X_PJAX"] === "true"
          end
        end
      end
    end
  end
end
