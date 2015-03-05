module ApplicationHelper

  #idea from here http://stackoverflow.com/questions/3841323/rails-page-titles
  def title(page_title)
    content_for(:title) { page_title }
  end
end
