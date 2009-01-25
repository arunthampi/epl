# http://news.bbc.co.uk/sport2/hi/football/teams/m/man_utd/fixtures/default.stm

module Futbol
  class SchedulesParser
    attr_accessor :source
    attr_reader   :fixtures_document, :team_id, :team_name
    
    def initialize(id, team_name)
      @team_id, @team_name = id, team_name
      self.source = "http://news.bbc.co.uk/sport2/hi/football/teams/#{id[0,1]}/#{id}/fixtures/default.stm"
      @fixtures_document = open(self.source) { |f| Hpricot(f) } 
    end
    
    def parse_schedules
      fixtures_array = []
      
      table = fixtures_document.search("//td[@width='416']").first
      fixtures = (table/'div')
      date, competition, details = "", "", ""
      
      fixtures.each_with_index do |f_component, idx|
        case idx % 3
        when 0 then
          date = f_component.innerHTML.gsub(/<b>|<\/b>/, '').split(",").last.strip
        when 1 then
          competition = f_component.innerHTML.gsub(/<b>|<\/b>/, '').strip
        when 2 then
          html = f_component.innerHTML
          
          verbose_details = html.split(',').first
          details = verbose_details.strip.gsub(/<a.*?>|<\/a>/, '').strip
          gmt_time = html.scan(/\d{2}:\d{2}/).first

          unix_time = Chronic.parse("#{date} at #{gmt_time}").to_i
          
          fixtures_array << Fixture.new(:details => details, :date => date, :gmt_time => gmt_time,
                                :unix_time => unix_time, :competition => competition)
          date, competition, details = "", "", ""
        end                      
      end
      
      fixtures_array
    end
    
  end
end