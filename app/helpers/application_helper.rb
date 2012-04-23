module ApplicationHelper
  def breadcrumbs
    raw render_crumbs :separator => ' / '
  end

  def text_with_icon(icon_name, text)
    raw("<i class=\"icon-#{icon_name}\"></i> #{text}")
  end
end
