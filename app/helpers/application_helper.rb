module ApplicationHelper
	def markdown(text)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
		return markdown.render(text).html_safe
	end
	
	def card_fields_class
		"hidden" if current_user.card_type?
	end

end
