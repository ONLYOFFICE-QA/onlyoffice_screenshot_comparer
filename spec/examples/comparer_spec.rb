require 'spec_helper'

describe 'FileScreenshotList' do
  it 'FileScreenshotList#compare' do
    with_chart = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_with_chart')
    without_chart = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_without_chart')
    expect(with_chart.compare(without_chart)).to include('Image image1.png differs for 0 (0)')
  end
end
