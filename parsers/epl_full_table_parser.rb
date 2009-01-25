module Futbol
  class FullTableParser
    attr_accessor :source
    attr_reader   :teams_document
    
    def initialize(source)
      self.source = source
      @teams_document = open(self.source) { |f| Hpricot(f) } 
    end
    
    def parse_all_teams
      epl_teams = []
      
      table = (teams_document/'table.fulltable').first
      teams = (table/'tr').select { |x| x.attributes['class'] =~ /r[1,2]/ }
      
      teams.each do |team|
        attributes = (team/'td'); attributes.shift
        team_name_element = (attributes.shift/'a').first
        team_url = team_name_element.attributes['href'].split("/")
        team_id, team_name = team_url[team_url.size - 2], team_name_element.innerHTML
        
        team_attributes = attributes.collect { |x| x.innerHTML }
        team = Team.new(:id => team_id, :name => team_name, :total_played => team_attributes[0],
                        :home_won => team_attributes[1], :home_drawn => team_attributes[2],
                        :home_lost => team_attributes[3], :home_for => team_attributes[4],
                        :home_against => team_attributes[5], :away_won => team_attributes[6],
                        :away_drawn => team_attributes[7], :away_lost => team_attributes[8],
                        :away_for => team_attributes[9], :away_against => team_attributes[10],
                        :goal_difference => team_attributes[11], :points => team_attributes[12])
        epl_teams << team                
      end
      
      epl_teams
    end
  end
end