module ApplicationHelper
  def flash_class(flash_type)
    if flash_type == 'notice'
      'bg-success'
    elsif flash_type == 'error'
      'bg-danger'
    else
      'bg-info'
    end
  end
end
