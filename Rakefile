require 'rubygems'
require 'json'
require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'chronic'
require 'fileutils'

require 'models/team'
require 'models/fixture'

require 'parsers/epl_full_table_parser'
require 'parsers/epl_schedules_parser'

namespace :epl do
  
  desc "Run the whole shebang"
  task :fetch_all do
    git_repo = ENV['epl_git_repo']
    if !File.exists?(git_repo)
      puts "The Git Repo you specified doesn't exist"
    else
      FileUtils.mkdir_p(File.join(git_repo, "js", "epl"))
      
      parser = Futbol::FullTableParser.new('http://news.bbc.co.uk/sport2/hi/football/eng_prem/table/default.stm')
      all_teams = parser.parse_all_teams
      
      all_teams.each do |team|
        FileUtils.mkdir_p(File.join(git_repo, "js", "epl", "teams", "fixtures"))
        schedules_parser = Futbol::SchedulesParser.new(team.id, team.name)
        fixtures = schedules_parser.parse_schedules
        
        File.open(File.join(git_repo, "js", "epl", "teams", "fixtures", "#{team.id}.js"), 'w') do |out|
          out.puts(fixtures.to_json)
        end
        puts "Finished writing Fixtures for #{team.id}, #{team.name}"
      end
      
      File.open(File.join(git_repo, "js", "epl", "all_teams.js"), 'w') do |out|
        out.puts(all_teams.to_json)
      end
      
      puts "Finished writing all_teams JSON"
      puts "*Done*"
    end
  end
  
  task :fetch_table do 
    git_repo = ENV['epl_git_repo']
    if !File.exists?(git_repo)
      puts "The Git Repo you specified doesn't exist"
    else
      FileUtils.mkdir_p(File.join(git_repo, "js", "epl"))
      
      parser = Futbol::FullTableParser.new('http://news.bbc.co.uk/sport2/hi/football/eng_prem/table/default.stm')
      all_teams = parser.parse_all_teams
      
      File.open(File.join(git_repo, "js", "epl", "all_teams.js"), 'w') do |out|
        out.puts(all_teams.to_json)
      end
      
      puts "Finished writing all_teams JSON"
      puts "*Done*"
    end
  end
  
end