require 'mini_magick'
require 'onlyoffice_s3_wrapper'

module OnlyofficeScreenshotComparer
  # Class for downloading screenshots for file
  class S3ScreenshotDownloader
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
  end
end
