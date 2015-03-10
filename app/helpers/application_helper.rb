module ApplicationHelper

  #idea from here http://stackoverflow.com/questions/3841323/rails-page-titles
  def title(page_title)

    content_for(:title) {
      app_name = Setting.obtain('title')
      "#{page_title} | #{app_name}"
    }
  end
end
