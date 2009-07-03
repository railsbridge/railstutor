class PagesController < ApplicationController
  def home
    @most_recent = WikiPage.find(:all, :limit => 20, :include => :content, :order => 'wiki_contents.updated_on DESC')
  end
end
