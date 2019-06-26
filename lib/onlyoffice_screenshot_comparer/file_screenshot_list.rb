# frozen_string_literal: true

require 'mini_magick'
require_relative 'file_screenshot_list/compare_result'

module OnlyofficeScreenshotComparer
  # Class for storing screeshots for file
  class FileScreenshotList
    # @return [Array<String>] list of files paths
    attr_accessor :files
    # @return [String] path to directory
    attr_reader :path

    # @param path [String] path to screenshots
    def initialize(path)
      @path = path
      @files = Dir["#{@path}/*"].map(&File.method(:realpath)).sort
    end

    # @param other [FileScreenshotList] compare with other screenshot list
    def compare(other)
      diff_path = Dir.mktmpdir
      result = ''
      files.each_with_index do |current_file, index|
        current_name = File.basename(current_file)
        file_to_compare = other.files[index]
        diff_file = "#{diff_path}/diff-#{current_name}"
        compare_result = `compare -metric RMSE #{current_file} #{file_to_compare} #{diff_file} 2>&1`
        result << "Image #{File.basename(current_file)} differs for #{compare_result}\n"
      end
      CompareResult.new(result, diff_path)
    end
  end
end
