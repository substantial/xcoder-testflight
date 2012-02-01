module Xcode
  
  class Builder
   
    def testflight(parameters = {})
      
      testflight_api_token = parameters[:testflight_api_token] || ENV['TESTFLIGHT_API_TOKEN']
      testflight_team_token = parameters[:testflight_team_token] || ENV['TESTFLIGHT_TEAM_TOKEN']
      message = parameters[:message]
      distribution_list = parameters[:distribution_list] || 'All'
      
      if (testflight_api_token.nil? and testflight_team_token.nil?) or message.nil?
        puts "You must specify a testflight_api_token, testflight_team_token, and a message"
        return
      end
      
      cmd = [ "curl -X POST http://testflightapp.com/api/builds.json" ]
      
      cmd << "-F file=@\"#{ipa_path}\" -F dsym=@\"#{dsym_zip_path}\""
      cmd << "-F api_token='#{testflight_api_token}'"
      cmd << "-F team_token='#{testflight_team_token}'"
      cmd << "-F notify=True -F notes=\"#{message}\" -F distribution_lists='#{distribution_list}'"
      
      yield cmd if block_given?
      
      Xcode::Shell.execute(cmd.to_a)
      
    end
    
  end
end