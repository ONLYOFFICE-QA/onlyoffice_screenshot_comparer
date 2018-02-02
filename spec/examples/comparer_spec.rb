require 'spec_helper'

describe 'FileScreenshotList' do
  it 'FileScreenshotList#compare text result' do
    with_chart = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_with_chart')
    without_chart = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_without_chart')
    expect(with_chart.compare(without_chart).result).to include('Image image1.png differs for 0 (0)')
  end

  it 'FileScreenshotList#compare path to images diff' do
    with_chart = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_with_chart')
    without_chart = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_without_chart')
    expect(Dir["#{with_chart.compare(without_chart).diff_path}/*"].first).to include('diff-image')
  end
end
