module Xcode
  
  class Builder
   
    def testflight(parameters = {})
      
      #
      # This uses the TestFlight API to send the particular build to the server 
      # for distribution.
      # 
      # @see https://testflightapp.com/api/doc/
      # 
      
      testflight_api_token = parameters[:testflight_api_token] || ENV['TESTFLIGHT_API_TOKEN']
      testflight_team_token = parameters[:testflight_team_token] || ENV['TESTFLIGHT_TEAM_TOKEN']
      message = parameters[:message]
      distribution_list = Array(parameters[:distribution_list]).join(', ')
      notify = parameters[:notify].to_s =~ /^true$/i
      replace = parameters[:replace].to_s =~ /^true$/i
      
      cmd = [ "curl -X POST http://testflightapp.com/api/builds.json" ]
      
      cmd << "-F file=@\"#{ipa_path}\""
      cmd << "-F dsym=@\"#{dsym_zip_path}\""
      cmd << "-F api_token='#{testflight_api_token}'"
      cmd << "-F team_token='#{testflight_team_token}'"
      cmd << "-F notify=True" if notify
      cmd << "-F notes=\"#{message}\""
      cmd << "-F distribution_lists='#{distribution_list}'" if distribution_list
      cmd << "-F replace=True" if replace
      
      yield cmd if block_given?
      
      Xcode::Shell.execute(cmd.to_a)
      
    end
    
  end
end