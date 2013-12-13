module DocumentsHelper

	def matched_keywords(report)
	  if params[:search]
       keys = report.keywords.map(&:keyword_text).select {|s| s.include? params[:search]}.join(", ")
       keyf = report.keyfindings.map(&:keyfinding_text).select {|s| s.include? params[:search]}.join(", ")
       return(keys + ", " + keyf ) if keys
       return(keyf) if keys.nil?
       return(keys) if keyf.nil?
       end
	end

end
