module Futbol
  class Team
    attr_accessor :id, :name, :total_played, :home_won, :home_drawn, :home_lost, :home_for,
                  :home_against, :away_won, :away_drawn, :away_lost, :away_for, :away_against,
                  :goal_difference, :points
                  
                  
    def initialize(opts = {})
      opts.each { |k,v| self.send("#{k}=", v) }
    end
    
    def to_json
      {
        'id' => id, 'name' => name, 'total_played' => total_played.to_i, 'home_won' => home_won.to_i,
        'home_drawn' => home_drawn.to_i, 'home_lost' => home_lost.to_i, 'home_for' => home_for.to_i,
        'home_against' => home_against.to_i, 'away_won' => away_won.to_i,
        'away_drawn' => away_drawn.to_i, 'away_lost' => away_lost.to_i, 'away_for' => away_for.to_i,
        'away_against' => away_against.to_i, 'goal_difference' => goal_difference.to_i,
        'points' => points.to_i
      }.to_json
    end
  end
  
end