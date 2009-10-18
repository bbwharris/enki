# Workaround a problem with script/plugin and http-based repos.
# See http://dev.rubyonrails.org/ticket/8189
Dir.chdir(Dir.getwd.sub(/vendor.*/, '')) do
 
  ##
  ## Copy over asset files (javascript/css/images) from the plugin directory to public/
  ##
 
  def copy_files(source_path, destination_path, directory)
    source, destination = File.join(directory, source_path), File.join(Rails.root, destination_path)
    FileUtils.mkdir(destination) unless File.exist?(destination)
    FileUtils.cp_r(Dir.glob(source+'/*.*'), destination)
  end
 
  directory = File.dirname(__FILE__)
 
  copy_files("/public", "/public", directory)

  [ :stylesheets, :javascripts, :images].each do |asset_type|
    spath = "/public/#{asset_type}"
    dpath = "/public/#{asset_type}/twitter_bird"
    copy_files(spath, dpath, directory)
  
  end
 
end
