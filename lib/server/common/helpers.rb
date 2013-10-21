require "server/models"

module Server
  module Common
    module Helpers
      include Server::Models

      def is_login?
        defined?(session[:login][:ip]) &&
          session[:login][:ip] == request.ip
      end

      def login_user
        halt 403 unless is_login?
        User.where(:github_user_id => session[:login][:github_user_id]).cache.first
      end

      def partial view
        haml view
      end

      def require_login &block
        redirect "/" unless is_login?
        yield
      end

      def livereload_tag
        if ENV['RACK_ENV'] === "development"
          puts "livereload enabled."
          "<script src='http://localhost:#{ENV["LIVERELOAD_PORT"]}/livereload.js'></script>"
        else
          ""
        end
      end
    end
  end
end
