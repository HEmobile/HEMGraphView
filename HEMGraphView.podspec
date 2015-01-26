Pod::Spec.new do |s|

  s.name          = "HEMGraphView"
  s.version       = "0.1"
  s.summary       = "Graph library for iOS."
  s.description   = <<-DESC
                      A graph library used in HE:mobile to create customizable line graphs.
                    DESC
  s.homepage      = "https://github.com/HEmobile/HEMGraphView"
  s.license       = "MIT"
  s.author        = { "HE:mobile" => "contato@hemobile.com.br" }
  s.source        = { :git => "https://github.com/HEmobile/HEMGraphView.git", :tag => "0.1" }
  s.source_files  = "HEMGraphView/*.{h,m}"
  s.requires_arc  = true

end
