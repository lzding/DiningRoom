class Users::SessionsController<Devise::SessionsController
  layout "no_authorization"

  def new

  end

  def create
    self.resource = warden.authenticate!(auth_options)
    #set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    #yield resource if block_given?
    #respond_with resource, location: after_sign_in_path_for(resource)
    render :json=>{result: true, role: current_user.role_id }
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    #set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    render :json => {result: true}
  end
end