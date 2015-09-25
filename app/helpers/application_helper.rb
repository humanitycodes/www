module ApplicationHelper

  def bootstrap_alert_class_for(flash_type)
    case flash_type.to_sym
      when :notice        then 'alert-info'
      when :error, :alert then 'alert-danger'
      else "alert-#{flash_type}"
    end
  end

end
