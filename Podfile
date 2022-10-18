# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

workspace 'RAWG'

def core_pods
pod 'Toast-Swift', '~> 5.0.1'
pod 'SwiftLint'
pod 'Declayout'
pod 'Alamofire'
end

target 'Profile' do
project 'Profile/Profile.project'
core_pods
end

target 'Router' do
project 'Router/Router.project'
end

target 'RAWG' do
project 'RAWG.project'
core_pods
end

