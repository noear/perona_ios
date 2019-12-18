source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!

workspace 'perona_ios'

target:perona do
    project 'perona/perona.xcodeproj'
end

target:demo_app do
#    pod 'perona'
    pod 'perona',:path=>"perona"
    pod 'demo_module2',:path=>"perona_demo/demo_module2"
    project 'perona_demo/demo_app/demo_app.xcodeproj'
end

target:demo_module2 do
#    pod 'perona'
    pod 'perona',:path=>"perona"
    project 'perona_demo/demo_module2/demo_module2.xcodeproj'
end
