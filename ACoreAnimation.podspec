Pod::Spec.new do |s|

  s.name         = "ACoreAnimation"
  s.version      = "0.1.2"
  s.summary      = "Advanced CoreAnimation."
  s.description  = "Advanced CoreAnimation approach."
  s.homepage     = "https://github.com/ihormyroniuk/ACoreAnimation"

  s.license      = "MIT"

  s.author       = { "Ihor Myroniuk" => "ihormyroniuk@gmail.com" }

  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/ihormyroniuk/ACoreAnimation.git", 
:tag => "0.1.2" }

  s.source_files = "ACoreAnimation/**/*.{swift}"

  s.swift_version = "4.2"

end
