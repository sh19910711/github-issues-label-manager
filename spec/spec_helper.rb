def source_env path
  File.readlines(path).each do |line|
    values = line.split "="
    ENV[values[0].strip] = values[1].strip
  end
end

GITHUB_ACCESS_TOKEN = ENV["GITHUB_ACCESS_TOKEN"]
TEST_EYE_GREP_MODE = ENV["TEST_EYE_GREP_MODE"] === "TRUE"

