require 'awesome_print'
require 'optparse'

Dir[File.join(__dir__, '..', 'lib', '*.rb')].sort.each { |file| require file }
