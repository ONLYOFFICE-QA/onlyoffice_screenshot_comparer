# frozen_string_literal: true

module OnlyofficeScreenshotComparer
  # Class for storing info about comparision
  class CompareResult
    # @return [String] info about result
    attr_reader :result
    # @return [String] path to result diff
    attr_reader :diff_path

    def initialize(result, diff_path)
      @result = result
      @diff_path = diff_path
    end

    # @return [True, False]Check if compare result seems same
    def same?
      @result.scan(/differs for (\d)/).flatten.uniq == ['0']
    end
  end
end
