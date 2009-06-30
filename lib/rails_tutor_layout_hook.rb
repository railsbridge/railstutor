class RailsTutorLayoutHook < Redmine::Hook::ViewListener
  # Add a CSS menu link
  def view_layouts_base_html_head(context = { })
    return stylesheet_link_tag "rails_tutor.css", :plugin => "redmine_railstutor", :media => "screen"
  end
end