module Sinatra
  module Extension
    module Session
      def self.registered app
        session_key    = app.session_settings[:key]
        session_secret = app.session_settings[:secret]

        if session_secret == ""
          abort "Fatal: session secret is empty"
        end

        app.use(
          Rack::Session::Cookie,
          :key          => session_key,
          :secret       => session_secret,
          :expire_after => 24 * 60 * 60 * 20,
        )
      end
    end
  end
end
