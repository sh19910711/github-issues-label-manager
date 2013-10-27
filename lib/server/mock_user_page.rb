module Server
  module MockUserPage
    def self.registered app
      app.get "/mock/repos/sh19910711/js2ch" do
        @github_user_id = "sh19910711"
        @github_repo_name = "js2ch"
        haml_pjax :user_repo
      end
    end
  end
end
