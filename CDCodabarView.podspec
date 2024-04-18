Pod::Spec.new do |s|
    s.name              = "CDCodabarView"
    s.version           = "1.3.0"
    s.swift_version     = "5.0"
    s.summary           = "Codabar Barcode Generator for iOS."
    s.homepage          = "https://github.com/Coledunsby/CDCodabarView"
    s.authors           = { "Cole Dunsby" => "coledunsby@gmail.com" }
    s.license           = { :type => "MIT", :file => 'LICENSE' }
    s.platform          = :ios, "12.0"
    s.requires_arc      = true
    s.source            = { :git => "https://github.com/Coledunsby/CDCodabarView.git", :tag => "#{s.version}" }
    s.source_files      = "Sources/CDCodabarView/*.swift"
    s.module_name       = s.name
end
