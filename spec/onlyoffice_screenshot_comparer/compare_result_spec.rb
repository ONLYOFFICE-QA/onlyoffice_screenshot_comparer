# frozen_string_literal: true

require 'spec_helper'

describe 'CompareResult' do
  it 'CompareResult#same? return true for same images' do
    data1 = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_with_chart')
    data2 = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_with_chart')
    expect(data1.compare(data2)).to be_same
  end

  it 'CompareResult#same? return false for not same images' do
    data1 = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_with_chart')
    data2 = OnlyofficeScreenshotComparer::FileScreenshotList.new('spec/examples/lost_chart/doc_without_chart')
    expect(data1.compare(data2)).not_to be_same
  end
end
