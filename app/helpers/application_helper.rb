module ApplicationHelper
  def active_class(cname, anames)
    return 'active' if controller_name == cname && anames.include?(action_name)
    ''
  end

  def flash_alert_class(name)
    case name
      when 'notice' then
        'alert-info'
      when 'warning' then
        'alert-warning'
      when 'success' then
        'alert-success'
      when 'error' then
        'alert-danger'
      else
        ''
    end
  end

  def flash_icon_class(name)
    case name
      when 'notice' then
        'icon-info'
      when 'warning' then
        'icon-warning'
      when 'success' then
        'icon-check'
      when 'error' then
        'icon-delete'
      else
        ''
    end
  end
end
