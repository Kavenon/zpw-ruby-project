module ApplicationHelper
  def flash_messages
    flash_messages = []

    flash.each do |type, message|
      return unless message

      level = case type
                when 'notice' then 'success'
                when 'danger' then 'warning'
                when 'alert'  then 'error'
                when 'info'   then 'info'
                when 'warn'   then 'warning'
                else
                  'info'
              end

      js = javascript_tag %{toastr.#{level}("#{message}");}

      flash_messages << js
    end

    flash_messages.join('/n').html_safe
  end
end
