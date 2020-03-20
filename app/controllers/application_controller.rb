class ApplicationController < ActionController::Base
  include Pundit
  helper_method :current_user, :logged_in?
  add_flash_types :success, :error, :warning

  before_action :verify_account
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError do
    if logged_in?
      redirect_to root_path, error: t('application.prohibited')
    else
      redirect_to root_path, warning: t('application.log_in_first')
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  private
  def verify_account
    return unless logged_in?
    return redirect_to edit_profile_path if current_user.guest?
    return redirect_to edit_volunteer_profile_path if current_user.volunteer? && !current_user.valid?
    return redirect_to edit_recipient_profile_path if current_user.recipient? && !current_user.valid?
  end

  def render_with_turbolinks(*options, &block)
    html = render_to_string(*options, &block)

    script = <<-SCRIPT
      (function(){
        Turbolinks.clearCache();
        var doc = document.implementation.createHTMLDocument('response');
        doc.documentElement.innerHTML = "#{ActionController::Base.helpers.j(html)}";
        document.documentElement.replaceChild(doc.body, document.body);
        Turbolinks.dispatch('turbolinks:load');
        window.scroll(0, 0);
      })();
    SCRIPT

    self.status = 200
    self.response_body = script
    response.content_type = 'text/javascript'
  end
end
