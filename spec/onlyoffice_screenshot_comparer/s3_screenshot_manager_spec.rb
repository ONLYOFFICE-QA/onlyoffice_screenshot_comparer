# frozen_string_literal: true

require 'spec_helper'

describe OnlyofficeScreenshotComparer::S3ScreenshotManager do
  screen_files = 'Алфавит.docx'
  it 'S3ScreenshotDownloader#document_list to include files' do
    expect(described_class.new(version: 'ver. 5.0.99 (build:458)').document_list).to include(screen_files)
  end

  it 'S3ScreenshotDownloader#download_screens contains some files' do
    files_location = described_class.new(version: 'ver. 5.0.99 (build:458)').download_screens(screen_files)
    expect(Dir["#{files_location}/*"].first).to include('image1.png')
  end
end
