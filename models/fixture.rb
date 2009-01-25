module Futbol
  class Fixture
    attr_accessor :details, :date, :gmt_time, :unix_time, :competition
    
    def initialize(opts = {})
      opts.each { |k,v| self.send("#{k}=", v) }
    end
    
    def to_json
      {
        'details' => details, 'date' => date, 'gmt_time' => gmt_time,
        'competition' => competition, 'unix_time' => unix_time
      }.to_json
    end
  end
end 