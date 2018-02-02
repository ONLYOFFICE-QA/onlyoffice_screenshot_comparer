require_relative 'lib/onlyoffice_screenshot_comparer.rb'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Task for generate report of comparing files'
task :compare_files do
  version1 = 'ver. 5.0.99 (build:461)'
  version2 = 'ver. 5.0.99 (build:463)'
  output = File.open("compare_#{version1}_#{version2}.log", 'w')
  docs = OnlyofficeScreenshotComparer::S3ScreenshotDownloader.new(version: version1).document_list
  docs.each do |current_file|
    screens1 = OnlyofficeScreenshotComparer::S3ScreenshotDownloader.new(version: version1).download_screens(current_file)
    screens2 = OnlyofficeScreenshotComparer::S3ScreenshotDownloader.new(version: version2).download_screens(current_file)
    list1 = OnlyofficeScreenshotComparer::FileScreenshotList.new(screens1)
    list2 = OnlyofficeScreenshotComparer::FileScreenshotList.new(screens2)
    output << "File #{current_file}\n#{list1.compare(list2)[:result]}\n"
  end
  output.close
end
