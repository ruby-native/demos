module ApplicationHelper
  def status_icon(todo)
    if todo.completed?
      content_tag(:span, class: "status-icon done", "aria-label": "Completed") do
        tag.svg(
          tag.path(d: "M5 13l4 4L19 7", stroke_linecap: "round", stroke_linejoin: "round"),
          viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: 3
        )
      end
    else
      content_tag(:span, "", class: "status-icon", "aria-label": "Open")
    end
  end

  def chevron_icon
    content_tag(:span, class: "chevron", "aria-hidden": "true") do
      tag.svg(
        tag.path(d: "M9 6l6 6-6 6", stroke_linecap: "round", stroke_linejoin: "round"),
        viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: 2
      )
    end
  end

  def due_chip(due_at)
    return "" unless due_at
    label =
      if due_at.to_date == Date.current
        due_at.strftime("%-l:%M %p")
      elsif due_at.to_date == Date.current + 1
        "Tomorrow"
      else
        due_at.strftime("%b %-d")
      end
    content_tag(:span, label, class: "due-chip")
  end

  def initials(value)
    return "" if value.blank?
    if value.include?("@")
      value.split("@").first.split(/[._-]/).first(2).map { |s| s[0] }.join.upcase
    else
      value.split(/\s+/).first(2).map { |s| s[0] }.join.upcase
    end
  end

  def web_fab(href:, label: "Add")
    return "" if native_app?
    link_to href, class: "web-fab", "aria-label": label do
      tag.svg(
        tag.path(d: "M12 5v14M5 12h14", stroke_linecap: "round"),
        viewBox: "0 0 24 24", fill: "none", stroke: "currentColor", stroke_width: 2.5
      )
    end
  end
end
