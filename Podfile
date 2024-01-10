# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

podfile_directory = File.expand_path(File.dirname(__FILE__))
flutter_application_path = File.join(podfile_directory, 'flutter/integrate_flutter_in_native')
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'IntergrateFlutterInNative' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  install_all_flutter_pods(flutter_application_path)
  # Pods for IntergrateFlutterInNative
end

post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
