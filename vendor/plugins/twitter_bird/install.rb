require File.dirname(__FILE__) + '/install_assets'

Dir.chdir(Dir.getwd.sub(/vendor.*/, '')) do
 
  ##
  ## Copy Initializers and Settings
  ##
 
  def copy_files(source_path, destination_path, directory)
    source, destination = File.join(directory, source_path), File.join(Rails.root, destination_path)
    FileUtils.mkdir(destination) unless File.exist?(destination)
    FileUtils.cp_r(Dir.glob(source+'/*.*'), destination)
  end
 
  directory = File.dirname(__FILE__)
 
  copy_files("/config", "/config", directory)
  copy_files("/config/initializers", "/config/initializers", directory)
 
end
