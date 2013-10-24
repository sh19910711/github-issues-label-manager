require "rake"

namespace :yard do
  desc "Show routes"
  task "routes" do
    require "yard/sinatra"
    YARD::Registry.load Dir.glob "lib/**/*.rb"
    YARD::Sinatra.routes.each do |route|
      puts "%-6s %s %s @ %s" % ["#{route.http_verb}:", route.http_path, route.docstring, route.file]
    end
    Rake::Task["clean"].execute
  end
end

