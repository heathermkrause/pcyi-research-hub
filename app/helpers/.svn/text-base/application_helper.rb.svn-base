module ApplicationHelper
  def get_forget_password_error(resource)
    ("Email " +resource.errors[:email][0]) if (!resource.errors[:email].blank? && resource.errors[:email].present?)
  end

  def get_name_error(resource)
    ("Name " +resource.errors[:name][0]) if (!resource.errors[:name].blank? && resource.errors[:name].present?)
  end

  def get_email_error(resource)
    ("Email " +resource.errors[:email][0]) if (!resource.errors[:email].blank? && resource.errors[:email].present?)
  end

  def get_password_error(resource)
    ("Password " +resource.errors[:password][0]) if (!resource.errors[:password].blank? && resource.errors[:password].present?)
  end

  def get_confirm_password_error(resource)
    ("Confirm password " +resource.errors[:password_confirmation][0]) if (!resource.errors[:password_confirmation].blank? && resource.errors[:password_confirmation].present?)
  end

  def get_confirm_password_error_for_reset(resource)
    ("Confirm Password " +resource.errors[:password_confirmation][0]) if (!resource.errors[:password_confirmation].blank? && resource.errors[:password_confirmation].present?)
  end

  def get_new_password_error(resource)
    ("Password " +resource.errors[:password][0]) if (!resource.errors[:password].blank? && resource.errors[:password].present?)
  end


  
end
