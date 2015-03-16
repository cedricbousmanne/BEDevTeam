class UserDecorator < Draper::Decorator
  delegate_all

  def interests
    if object.interest_list.any?
      h.content_tag(:strong, "Interests: ") +
      tag_list(object.interest_list)
    end
  end

  def skills
    if object.skill_list.any?
      h.content_tag(:strong, "Skills: ") +
      tag_list(object.skill_list)
    end
  end

  def tag_list(collection)
    collection.map do |item|
      h.content_tag(:span, class: "label label-info tags") do
        item
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
    [linkedin_link]
  end

  def linkedin_link
    h.link_to("LinkedIn", linkedin_profile)
  end
end
