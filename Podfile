# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

workspace 'RAWG'

#profile module
def profile_pods
pod 'Declayout'
pod 'Toast-Swift', '~> 5.0.1'
pod 'SwiftLint'
end

target 'Profile' do
project 'Profile/Profile.project'
profile_pods
end


#RAWG module
pod 'Declayout'
pod 'Alamofire'
pod 'Toast-Swift', '~> 5.0.1'
pod 'SwiftLint'

target 'RAWG' do
project 'RAWG.project'
end

