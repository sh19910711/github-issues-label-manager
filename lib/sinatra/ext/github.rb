require "oauth2"
require "addressable/uri"

module Sinatra
  module Extension
    module GitHub
      module Helpers
        # hash to url query
        def get_query_string target
          uri = Addressable::URI.new
          uri.query_values = target
          uri.query
        end
      end

      def self.registered app
        app.helpers GitHub::Helpers

        client_id             = app.github_settings[:client_id]
        client_secret         = app.github_settings[:client_secret]
        success_callback_url  = app.github_settings[:success_callback_url]
        success_callback_func = app.github_settings[:success_callback_func]
        fail_callback_url     = app.github_settings[:fail_callback_url]
        fail_callback_func    = app.github_settings[:success_callback_func]

        app.before do
          @github_client = OAuth2::Client.new(
            client_id,
            client_secret,
            :site               => "https://github.com",
            :authorize_url      => "/login/oauth/authorize",
            :token_url          => "/login/oauth/access_token",
          )
        end

        # Login
        app.post "/github/auth/login" do
          redirect @github_client.auth_code.authorize_url(
            :scope => "public_repo"
          )
        end

        # OAuth callback
        app.get "/github/auth/callback" do
          code = params[:code]
          redirect "/github/auth/fail" if code.nil? || code.to_s.empty?
          begin
            access_token = @github_client.auth_code.get_token code
          rescue
            redirect "/github/auth/fail"
          end
          session[:github_access_token] = access_token.token
          redirect "/github/auth/success"
        end

        # Auth success
        app.get "/github/auth/success" do
          instance_eval &success_callback_func if success_callback_func
          redirect success_callback_url if success_callback_url
          "OK"
        end

        # Auth fail
        app.get "/github/auth/fail" do
          instance_eval fail_callback_func if fail_callback_func
          redirect fail_callback_url if fail_callback_url
          "NG"
        end
      end
    end
  end
end
