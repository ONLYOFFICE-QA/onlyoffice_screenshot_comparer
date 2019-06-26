# frozen_string_literal: true

require 'mini_magick'
require 'onlyoffice_s3_wrapper'

module OnlyofficeScreenshotComparer
  # Class for downloading screenshots for file
  class S3ScreenshotManager
    # @return [OnlyofficeS3Wrapper::AmazonS3Wrapper.new] s3 wrapper
    attr_reader :s3

    def initialize(s3: OnlyofficeS3Wrapper::AmazonS3Wrapper.new(bucket_name: 'documentserver-docs-images', region: 'us-east-1'),
                   version: nil)
      @s3 = s3
      @version = version
    end

    # @return [Array<String>] list of doc screenshot stored
    def document_list
      list_files = @s3.get_files_by_prefix(@version)
      dirs = list_files.map { |cur_file| File.dirname(cur_file) }.uniq
      dirs.map { |cur_file| File.basename(cur_file) }.uniq
    end

    # @param document [String] name of doc
    # @return [String] path to file dir
    def download_screens(document)
      dir_for_screens = Dir.mktmpdir
      screenshot_files = @s3.get_files_by_prefix("#{@version}/#{document}")
      screenshot_files.each do |file|
        @s3.download_file_by_name(file, dir_for_screens)
      end
      dir_for_screens
    end

    # @param result_path [String] folder with result
    # @param s3_name [String] s3 folder name
    # @return [void] path to file dir
    def upload_compare_results(result_path, s3_name)
      list_of_files = Dir["#{result_path}/*"]
      list_of_files.each do |file|
        @s3.upload_file(file, "#{s3_name}/")
      end
    end
  end
end
