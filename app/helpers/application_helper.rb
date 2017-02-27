module ApplicationHelper
	def flash_class(msg_type)
		case msg_type
		when 'notice' then 'alert alert-info'
		when 'success' then 'alert alert-success'
		when 'error' then 'alert alert-danger'
		end
	end
end
