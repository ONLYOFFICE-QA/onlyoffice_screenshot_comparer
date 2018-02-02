require 'spec_helper'

describe 'S3ScreenshotDownloader' do
  screen_files = 'Алфавит.docx'
  it 'S3ScreenshotDownloader#document_list' do
    expect(OnlyofficeScreenshotComparer::S3ScreenshotDownloader.new(version: 'ver. 5.0.99 (build:458)').document_list).to include(screen_files)
  end

  it 'S3ScreenshotDownloader#document_list' do
    files_location = OnlyofficeScreenshotComparer::S3ScreenshotDownloader.new(version: 'ver. 5.0.99 (build:458)').download_screens(screen_files)
    expect(Dir["#{files_location}/*"].first).to include('image1.png')
  end
end
