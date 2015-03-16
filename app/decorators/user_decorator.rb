class UserDecorator < Draper::Decorator
  delegate_all
  include Rails.application.routes.url_helpers

  def interests
    if object.interest_list.any?
      h.content_tag(:strong, "Interests: ") +
      tag_list(object.interests, "interest")
    end
  end

  def skills
    if object.skill_list.any?
      h.content_tag(:strong, "Skills: ") +
      tag_list(object.skills, "skill")
    end
  end

  def tag_list(collection, type)
    collection.map do |item|
      h.content_tag(:span, class: "label label-info tags") do
        h.link_to item.name, h.send("#{type}_path", item.slug)
      end
    end.join(" ").html_safe
  end

  def social_media_links
    if social_media_link_list.any?
      h.content_tag(:strong, "Social Media: ") +
      social_media_link_list.join(' ').html_safe
    end
  end

  def social_media_link_list
    [linkedin_link, twitter_link, github_link]
  end

  def social_media_icon(social_media)
    html_class = ""
    case social_media
    when "twitter", "linkedin", "github"
      html_class = "fa-#{social_media}"
    end
    h.content_tag(:i, "", class: "fa #{html_class}")

  end

  %w(linkedin twitter github).each do |social_media|
    user_attr = "#{social_media}_profile"
    define_method "#{social_media}_link" do
      h.link_to(social_media_icon(social_media), eval(user_attr), class: 'btn btn-xs btn-default') if eval(user_attr).present?
    end
  end

end
