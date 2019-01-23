
$NEED_PING= true

config=YAML.load(File.open("#{Rails.root}/config/config.yaml"))
# load format
format_config=config['format']
$CSVSP=format_config[:csv_splitor] # csv splitor
$UPMARKER=format_config[:update_marker]
$FILE_MAX_SIZE=format_config[:file_max_size]

#load path
path_config=config['path']
$UPDATAPATH=path_config[:updata_file_path]
$DOWNLOADPATH=path_config[:download_file_path]
$TEMPLATEPATH=path_config[:template_file_path]
$USERPATH=path_config[:import_users_file_path]
$tmp_file_path='app/uploadfiles/tmp'



WillPaginate.per_page = 20


$pick_order_time_limit = '16:50:00'
$normal_off_duty_time = '18:00:00'