require "rack/csrf"

module Sinatra
  module Extension
    module Csrf
      def self.registered app
        app.use(
          Rack::Csrf,
          :field => 'csrf_token',
          :raise => true,
          :skip  => [
          ],
        )
        app.configure :production, :development do
          app.helpers do
            def get_csrf_token
              Rack::Csrf.csrf_token env
            end
            def get_csrf_tag
              Rack::Csrf.csrf_tag env
            end
          end
        end
      end
    end
  end
end
