# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Iqama' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Iqama
  pod 'SnapKit', '~> 0.22.0'
  pod 'MaterialControls', '~> 1.2'
  pod 'MaterialActionSheetController', '~> 1.0'
  
  post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
          # Configure Pod targets for Xcode 8 compatibility
          config.build_settings['SWIFT_VERSION'] = '2.3'
          config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
      end
  end

  target 'IqamaTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'IqamaUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
