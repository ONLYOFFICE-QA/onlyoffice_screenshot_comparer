require 'mini_magick'

module OnlyofficeScreenshotComparer
  # Class for storing screeshots for file
  class FileScreenshotList
    # @return [Array<String>] list of files paths
    attr_accessor :files

    # @param path [String] path to screenshots
    def initialize(path)
      @files = Dir["#{path}/*"].map(&File.method(:realpath)).sort
    end

    # @param other [FileScreenshotList] compare with other screenshot list
    def compare(other)
      return "Count of file images are not equal: #{files.length} vs #{other.files.length}" if files.length != other.files.length
      result = ''
      files.each_with_index do |current_file, index|
        file_to_compare = other.files[index]
        compare_result = `compare -metric RMSE #{current_file} #{file_to_compare} /dev/null 2>&1`
        result << "Image #{File.basename(current_file)} differs for #{compare_result}\n"
      end
      result
    end
  end
end
