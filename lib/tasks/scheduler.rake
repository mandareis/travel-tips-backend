desc "This task is called by the Heroku scheduler add-on"
task :refresh_suggestion_scores => :environment do
  puts "Updating suggestion scores..."
  SuggestionScore.refresh_all
  puts "done."
end
