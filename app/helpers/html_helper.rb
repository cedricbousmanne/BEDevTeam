module HtmlHelper
  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      content_for?(:title) ? content_for(:title) + " &raquo; ".html_safe +  ENV['default_title'] : ENV['default_title']
    end
  end

  def meta_description(meta_description = nil)
    if meta_description.present?
      content_for :meta_description, meta_description
    else
      content_for?(:meta_description) ? content_for(:meta_description) : ENV['default_meta_description']
    end
  end

end
