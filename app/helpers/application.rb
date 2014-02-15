module ServerHelper 
	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]
	end

	def time_ago(start_time)
	  diff_seconds = (Time.now - start_time).to_i
	  case diff_seconds
	    when 0..59
	      "#{diff_seconds}s"
	    when 60..3599
	      "#{diff_seconds/60}m"
	    when 3600 .. (3600*24-1)
	      "#{diff_seconds/3600}h"
	    else
	      start_time.strftime("%-d %b")
  	end
  end
end

