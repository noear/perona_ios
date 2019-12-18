Pod::Spec.new do |s|
  s.name         = "perona"
  s.version      = "0.1.13"
  s.summary      = "perona"
  s.description  = <<-DESC
                  Just Test Model
                   DESC
  s.homepage     = "http://code.data.zm/noear/perona_ios"
  s.license      = "MIT"
  s.author       = { "noear" => "noear@live.cn" }
  s.platform     = :ios, "9.0"
  s.source       = {:path=>"perona"}
  s.source_files = "perona/**/*.{h,m}"
  s.public_header_files = "perona/**/*.h"
  s.requires_arc = true
  
end
