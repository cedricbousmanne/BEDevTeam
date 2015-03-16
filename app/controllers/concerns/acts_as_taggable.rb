module ActsAsTaggable
  extend ActiveSupport::Concern

  def show
    @taggable = User.tagged_with(tag.name)
    render "taggables/show"
  end

  private

  def tag
    @tag ||= ActsAsTaggableOn::Tag.friendly.find(params[:id])
  end

  def set_title
    case controller_name
    when "interests"
      @page_title = "Developers with interest in #{tag.name}"
    when "skills"
      @page_title = "Developers with skills in #{tag.name}"
    end
  end


end
