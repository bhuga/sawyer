module Sawyer
  VERSION = "0.0.1"

  class Error < StandardError; end
end

%w(
  relation
).each { |f| require File.expand_path("../sawyer/#{f}", __FILE__) }