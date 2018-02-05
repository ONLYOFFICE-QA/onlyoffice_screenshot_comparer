require_relative 'lib/onlyoffice_screenshot_comparer.rb'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Task for generate report of comparing files'
task :compare_files, [:version1, :version2] do |_t, args|
  version1 = args[:version1]
  version2 = args[:version2]
  screens1 = OnlyofficeScreenshotComparer::S3ScreenshotManager.new(version: version1)
  screens2 = OnlyofficeScreenshotComparer::S3ScreenshotManager.new(version: version2)
  output = File.open("compare_#{version1}_#{version2}.log", 'w')
  diff_s3_path = "#{version1}/!result/#{version1} vs #{version2}/"
  docs = OnlyofficeScreenshotComparer::S3ScreenshotManager.new(version: version1).document_list
  docs.each do |current_file|
    list1 = OnlyofficeScreenshotComparer::FileScreenshotList.new(screens1.download_screens(current_file))
    list2 = OnlyofficeScreenshotComparer::FileScreenshotList.new(screens2.download_screens(current_file))
    compare = list1.compare(list2)
    output << "File #{current_file}\n#{compare.result}\n"
    next if compare.same?
    screens1.upload_compare_results(compare.diff_path, "#{diff_s3_path}/#{current_file}")
  end
  output.close
  screens1.s3.upload_file(output.path, diff_s3_path)
end
