require 'redmine'
require 'rails_tutor_layout_hook'

Redmine::Plugin.register :redmine_railstutor do
  name 'Hide Projects'
  author 'Dana Jones'
  url 'http://www.sterlingrosedesign.com/'
  author_url 'http://www.sterlingrosedesign.com/'
  description 'The Redmine Hide Projects plugin is used to hide the projects link at the top of the template except for admins.'
  version '0.1.0'
  
  delete_menu_item(:top_menu, :projects)
  Redmine::MenuManager.map :top_menu do |menu|
    menu.push :wiki, '/projects/rails-tutor/wiki', :caption => :label_wiki
    menu.push :projects, { :controller => 'projects', :action => 'index' }, :caption => :label_project_plural, :if => 
      Proc.new { User.current.admin? }
  end
end

