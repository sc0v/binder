class ListAlertsReport < Dossier::Report
  # Don't forget to restart server to test changes to reports.

  def self.binder_report_info
    {
        title: "List alerts information",
        description: "This report lists the information needed by CMU Alerts for all Carnival members"
    }
  end


  def format_header(column_name)
    if column_name == 'First Name'
      return "First Name"
    elsif column_name == 'Last Name'
      return "Last Name"
    elsif column_name == 'Andrew ID'
      return "Andrew ID"
    elsif column_name == 'Phone Carrier'
      return "Phone Carrier"
    elsif column_name == 'SC Admins'
      return "SC Admins"
    elsif column_name == 'SC Booth Chairs'
      return "SC Booth Chairs"
    elsif column_name == 'SC Booth Members'
      return "SC Booth Members"
    elsif column_name == 'SC Carnival Committee'
      return "SC Carnival Committee"
    else return column_name
    end
  end
  
  def format_phone_number(value)
    return ActionController::Base.helpers.number_to_phone(value)
  end

  def sql
    "
    SELECT `First Name`, `Last Name`, `Andrew ID`, `Phone Number`, `Phone Carrier`, `SC Admins`, `SC Booth Chairs`, 'x' as 'SC Booth Members', `SC Carnival Committee`
      FROM ( SELECT p.id, REPLACE(p.cached_name, p.cached_surname, '') as 'First Name', 
    	     p.cached_surname as 'Last Name', p.andrewid as 'Andrew ID', 
    	     p.phone_number as 'Phone Number', pc.name as 'Phone Carrier'
    		   FROM participants as p
    		   LEFT JOIN phone_carriers as pc
    		     ON p.phone_carrier_id = pc.id) as pi
    LEFT JOIN ( SELECT p.id, 'x' as 'SC Admins'
    			  FROM participants as p
    			  JOIN users as u
    				ON p.user_id = u.id
    			  JOIN users_roles as ur
    				ON ur.user_id = u.id
    			 WHERE ur.role_id = 1) as a
    	   ON pi.id = a.id
    LEFT JOIN ( SELECT p.id, 'x' as 'SC Booth Chairs' FROM memberships as m
    			  LEFT JOIN participants as p
    				ON p.id = m.participant_id
    			 WHERE m.is_booth_chair = 1
    			GROUP BY p.id) as b
    	   ON pi.id = b.id
    LEFT JOIN ( SELECT p.id as 'id', 'x' as 'SC Carnival Committee'
    			  FROM memberships as m
    			  LEFT JOIN participants as p
    				ON  p.id = m.participant_id
    			  LEFT JOIN organizations as o
    				ON m.organization_id = o.id
    			 WHERE o.name LIKE '%Carnival%') as c
    	   ON pi.id = c.id;
  	"
  end
end