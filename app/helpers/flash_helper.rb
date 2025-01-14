module FlashHelper
  def display_flash_messages
    flash.map do |key, value|
      content_tag(:div, value, class: "alert alert-#{key == 'notice' ? 'success' : 'danger'}")
    end.join.html_safe
  end
end