require "rubygems"
gem "mocha"
require "minitest"
require "minitest/autorun"
require "mocha/mini_test"
require "simplecov"
SimpleCov.start

def with_stdio
  stdin = $stdin
  $stdin, input = IO.pipe
  stdout = $stdout
  output, $stdout = IO.pipe
  yield input, output
  input.close
  $stdin = stdin
  output.close
  $stdout = stdout
end
