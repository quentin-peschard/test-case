require 'json'
require_relative '../../lib/car'
require_relative '../../lib/rental'


class FileHandlers
  class Writer
    def initialize(key, value)
      @key = key
      @value = value
    end

    def call
      create_output_file
    end

    def create_output_file
      File.open('data/output.json', 'w') do |file|
        file.write(JSON.pretty_generate({ @key => @value }))
      end
    end
  end
end
