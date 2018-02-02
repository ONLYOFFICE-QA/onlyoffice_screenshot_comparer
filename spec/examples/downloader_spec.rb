require 'spec_helper'

describe 'S3ScreenshotDownloader' do
  it 'S3ScreenshotDownloader#document_list' do
    expect(OnlyofficeScreenshotComparer::S3ScreenshotDownloader.new(version: 'ver. 5.0.99 (build:458)').document_list).to include('Алфавит.docx')
  end
end
