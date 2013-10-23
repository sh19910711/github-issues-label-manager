namespace :requirejs do
  desc "Show paths"
  task :paths do
    paths = Dir.glob "src/coffee/*.coffee"
    paths.each do |path|
      rel_path = path.match(/^src\/coffee\/(.*)\.coffee$/)[1]
      puts "\"app/#{rel_path}\": \"/lib/app/js/#{rel_path}\""
    end
  end
end
