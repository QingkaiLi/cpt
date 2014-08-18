namespace :assets do
  desc "Make all embedded assets in stylesheets relative paths"
  task :relativize => :environment do
    Dir[Rails.root.join("public/assets") + "*.css"].each do |asset|
      contents = File.read(asset)
      File.open(asset, "w") do |file|
        file.puts contents.gsub("url(/assets/", "url(")
      end
    end
  end
end

