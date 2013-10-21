require "rake"

namespace :yard do
  desc "Show routes"
  task "routes" do
    require "yard/sinatra"
    YARD::Registry.load Dir.glob "lib/**/*.rb"
    YARD::Sinatra.routes.each do |route|
      puts route.http_verb, route.http_path, route.file, route.docstring
    end
    Rake::Task["clean"].execute
  end
end

