module ApplicationHelper
  def error_explanation(attribute)
    if attribute.errors.any?
      if action_name == 'move_copy'
        header = content_tag :li, "This #{controller_name.classify} cannot move(copy) to the content pack because it contains #{pluralize attribute.errors.messages.count, 'error'}:".humanize
      else
        header = content_tag :li, "This #{controller_name.classify} cannot be #{attribute.id ? "modified" : "created"} because it contains #{pluralize attribute.errors.messages.count, 'error'}:".humanize
      end
      messages = attribute.errors.messages.collect{|name, value| content_tag(:li, value.first.humanize)}
      content_tag :ul, header, :class => "alert-explanation pure-u-1" do
        header << messages.join.html_safe
      end
    end
  end
end
