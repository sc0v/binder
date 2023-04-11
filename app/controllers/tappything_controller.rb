class TappythingController < ApplicationController
    def lookup
        id = params[:card]
        if id == nil
            # Respond Invalid
            @response = "INVALID"
        else
            participant = Participant.find_by_card(id)
            # If participant not in database or hasn't signed waiver, reject
            if participant.blank? || !participant.signed_waiver
                # Card ID not in Database
                @response = "NO"
            else
                membershipArr = Membership.where(:participant_id => participant.id)
                organizationArr = membershipArr.map{
                    |m| Organization.find_by(id: m.organization_id)
                }
                # List of Organizations that Shouldn't be On Midway
                badOrganizations = [
                        Organization.find_by(name: "Activities Board"),
                        Organization.find_by(name: "Habitat for Humanity"),
                        Organization.find_by(name: "Hard Hat Steel-ers")
                ]
                # If intersection of two arrays is not [], reject
                shouldReject = organizationArr & badOrganizations
                if shouldReject.length() != 0
                    # Participant is in Bad Org
                    @response = "NO"
                else
                    @response = "YES"
                end
            end
        end
        render plain: @response
    end
end
