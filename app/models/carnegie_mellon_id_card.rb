class CarnegieMellonIDCard

  def self.search full_card_number
    card_number = full_card_number[1,9]
    lookup = ActiveSupport::JSON.decode(
                 RestClient.get(
                                "http://merichar-dev.eberly.cmu.edu/cgi-bin/card-lookup?card_id=#{card_number}"
                 )
               )
    unless lookup.nil?
      lookup['andrewid']
    end
  end

end
