module Terraspace::Cloud::Api::Concern
  module Errors
    def errors?(result)
      result.is_a?(Hash) && result.key?("errors")
    end

    def error_message(result)
      $stderr.puts "ERROR: #{result["errors"]}"
      $stderr.puts "Your current settings. org: #{@org} project: #{@project}"
    end

    def valid?
      if @options[:type] == "deployment" && !@options[:stack]
        puts "ERROR: When using --type deployment, please specify the env. IE: --stack NAME"
        return false
      elsif @options[:type] == "stack" && !@options[:stack]
        puts "ERROR: When using --type stack, please specify the env. IE: --stack NAME"
        return false
      elsif @options[:type] == "env" && @options[:stack] # in case user accidentally specifies stack. env is inferred
        puts "ERROR: When using --type env, please specify the env. IE: --env NAME."
        puts "Note: you can also not specify it and the current TS_ENV is used."
        return false
      end
      true
    end
  end
end
