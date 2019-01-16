class FilesController<ApplicationController
  # skip_before_action :configure_permitted_parameters

  def download
    response.headers['Content-type'] = 'image/jpeg'

    path=File.join('app/uploadfiles', params[:folder], params[:file])
    send_file path, filename: params[:file], disposition: :attachment, type: "application/xlsx"


    # user_agent = request.user_agent.downcase
    # Rails.logger.info("浏览器 user_agent: #{user_agent}")
    # @file_name = params[:file]
    # @escaped_file_name = (user_agent.include?('trident') || user_agent.include?('edge')) ? CGI::escape(@file_name) : @file_name
    # send_file(path, :type=>'application/octet-stream;charset=utf-8', filename: @escaped_file_name, :x_sendfile=>true)
  end

  def index
    puts params
    # send_file File.join($TEMPLATEPATH, params[:id]+'.'+params[:format])

  end

  def show
    send_file Base64.urlsafe_decode64(params[:id])
  end
end