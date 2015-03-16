module ApplicationHelper
  def bootstrap_class_for flash_type

    case flash_type.to_sym
    when :success
      "alert-success"
    when :error
      "alert-error"
    when :alert
      "alert-block"
    when :notice
      "alert-info"
    else
      flash_type.to_s
    end
  end

  def join_now_link
    link_to signin_path, class: "btn btn-primary btn-lg mt20 mb20" do
      "Join now"
    end
  end
end
