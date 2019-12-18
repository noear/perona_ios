Pod::Spec.new do |s|
  s.name         = "demo_module2"
  s.version      = "0.0.1"
  s.summary      = "demo_module2"
  s.description  = <<-DESC
                  Just Test Model
                   DESC
  s.homepage     = "http://code.data.zm/noear/perona_ios"
  s.license      = "MIT"
  s.author       = { "noear" => "noear@live.cn" }
  s.platform     = :ios, "9.0"

  s.source       = {:path=>"demo_module2"}
  s.source_files = "demo_module2/**/*.{h,m}"
  
#  s.resources   = 'demo_module2/**/*.{bundle,xcassets}','demo_module2/**/perona.plist'
  s.resource_bundles = {
      'demo_module2' => [
        'demo_module2/**/*.{bundle,xcassets}',
        'demo_module2/**/perona.plist'
      ]}
  
  s.public_header_files = "demo_module2/**/*.h"
  s.requires_arc = true
  
  s.dependency "perona"
end
