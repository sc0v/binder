class CarnegieMellonIDCard

  def self.search full_card_number
    
    # Three track readers start with a % and then the card number 
    # followed by lots of stuff.
    # Single track readers will just spit out the card number
    if full_card_number[0] == '%'
      card_number = full_card_number[1,9]
    else
      card_number = full_card_number
    end
    
    lookup = ActiveSupport::JSON.decode( RestClient.get( "http://merichar-dev.eberly.cmu.edu/cgi-bin/card-lookup?card_id=#{card_number}") )
    
    unless lookup.nil?
      lookup['andrewid']
    end
  end

end
