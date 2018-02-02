require 'spec_helper'

describe 'CompareResult' do
  it 'CompareResult#same? return true for same images' do
    data1 = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_with_chart')
    data2 = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_with_chart')
    expect(data1.compare(data2).same?).to be_truthy
  end

  it 'CompareResult#same? return false for not same images' do
    data1 = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_with_chart')
    data2 = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_without_chart')
    expect(data1.compare(data2).same?).to be_falsey
  end
end
