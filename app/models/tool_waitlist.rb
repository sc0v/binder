class ToolWaitlist < ApplicationRecord
    has_many :tool_waitlist_entries
    belongs_to :tool_type
 
    # testing in Rails Console
    #  sl = ToolType.find_by(name:"Scissor Lift")
    #  scc = Organization.find_by(short_name:"SCC")
    #  aepi = Organization.find_by(short_name:"AEPi")
    #  p = Participant.first
    #  start_time_ex = DateTime.new(2012, 8, 29, 22, 35, 0)
    #  end_time_ex = DateTime.new(2012, 8, 29, 23, 35, 0)
    #  sl_wl=ToolWaitlist.create(tool_type_id:sl.id)
    #  ToolWaitlistEntry.create(organization_id:scc.id, participant_id:p.id, tool_waitlist_id: sl_wl.id, start_at: start_time_ex, note:"first try of waitlist functionality")
    #  ToolWaitlistEntry.create(organization_id:aepi.id, participant_id:p.id, tool_waitlist_id: sl_wl.id, start_at: start_time_ex, note:"first try of waitlist functionality")
    #  ToolWaitlistEntry.create(organization_id:scc.id, participant_id:p.id, tool_waitlist_id: sl_wl.id, start_at: start_time_ex, end_at: end_time_ex, status:2)
    #  ToolWaitlistEntry.all.map{|x| x.destroy}
    

end