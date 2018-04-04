class ListAlertsReport < Dossier::Report
  # Don't forget to restart server to test changes to reports.

  def self.binder_report_info
    {
        title: "List alerts info",
        description: "This report lists the information needed by CMU Alerts for all Carnival members"
    }
  end

  def sql
    "SELECT 
  REPLACE(p.cached_name, p.cached_surname, '') as 'First Name', p.cached_surname as 'Last Name', p.andrewid as 'Andrew ID', p.phone_number as 'Phone Number', pc.name as 'Phone Carrier', CASE WHEN r.role_id = 1 THEN 'x' ELSE NULL END as 'SC Admins', CASE WHEN count(CASE WHEN m.is_booth_chair = 't' THEN 1 ELSE NULL END) THEN 'x' ELSE NULL END as 'SC Booth Chairs', 'x' as 'SC Booth Members', scc_member as 'SC Carnival Committee'
  	FROM participants as p
  	LEFT JOIN users as u
  	  ON p.user_id = u.id
  	LEFT JOIN memberships as m
  	  ON p.id = m.participant_id
  	LEFT JOIN organizations as o
  	  ON m.organization_id = o.id
  	LEFT JOIN users_roles as r
  	  ON r.user_id = u.id
  	LEFT JOIN phone_carriers as pc
  	  ON pc.id = p.phone_carrier_id
  	LEFT JOIN (  	
  			    SELECT tmp_p.id as 'id', 'x' as scc_member
			  	  FROM participants as tmp_p
			  	  LEFT JOIN memberships as tmp_m
			  	    ON  tmp_p.id = tmp_m.participant_id
			 	  LEFT JOIN organizations as tmp_o
			 	    ON tmp_m.organization_id = tmp_o.id
			 	 WHERE tmp_o.name LIKE '%Carnival%'
			   ) as scc
  		  ON p.id = scc.id
  	GROUP BY p.andrewid"
  end
end