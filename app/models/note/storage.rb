require 'fileutils'

class Note
  class Storage
    DEFAULT_DIR = "./storage"

    def initialize(dir = DEFAULT_DIR)
      @current_dir = dir
      unless File.directory?(@current_dir)
        FileUtils.mkdir_p(@current_dir)
      end
    end

    def write(content)
      id =  new_filename
      File.write(full_path(id), content)
      id
    end

    def read(id)
      File.open(full_path(id)).read
    end

    private

    def full_path(id)
      "#{@current_dir}/#{id}"
    end

    def new_filename
      max_id = Dir.entries(@current_dir).map(&:to_i).max
      max_id ||= 0
      max_id + 1
    end
  end
end