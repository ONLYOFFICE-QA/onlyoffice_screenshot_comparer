require_relative 'lib/onlyoffice_screenshot_comparer.rb'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Task for generate report of comparing files'
task :compare_files do
  version1 = 'ver. 5.0.7 (build:38)'
  version2 = 'ver. 5.0.99 (build:463)'
  output = File.open("compare_#{version1}_#{version2}.log", 'w')
  docs = OnlyofficeScreenshotComparer::S3ScreenshotManager.new(version: version1).document_list
  docs.each do |current_file|
    screens1 = OnlyofficeScreenshotComparer::S3ScreenshotManager.new(version: version1)
    screens2 = OnlyofficeScreenshotComparer::S3ScreenshotManager.new(version: version2)
    list1 = OnlyofficeScreenshotComparer::FileScreenshotList.new(screens1.download_screens(current_file))
    list2 = OnlyofficeScreenshotComparer::FileScreenshotList.new(screens2.download_screens(current_file))
    compare = list1.compare(list2)
    output << "File #{current_file}\n#{compare.result}\n"
    next if compare.same?
    screens1.upload_compare_results(compare.diff_path, "#{version1} vs #{version2}/#{current_file}")
  end
  output.close
end
