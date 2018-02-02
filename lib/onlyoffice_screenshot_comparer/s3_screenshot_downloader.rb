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
      list_files = @s3.bucket.objects(prefix: @version).collect(&:key)
      dirs = list_files.map { |cur_file| File.dirname(cur_file) }.uniq
      dirs.map { |cur_file| File.basename(cur_file) }.uniq
    end
  end
end
