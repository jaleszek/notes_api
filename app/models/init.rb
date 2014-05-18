require_relative 'note'
Dir[File.dirname(__FILE__) + '/note/*.rb'].each {|file| require_relative file }