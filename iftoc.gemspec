# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iftoc/version'

Gem::Specification.new do |spec|
  spec.name          = "iftoc"
  spec.version       = Iftoc::VERSION
  spec.authors       = ["庞海礁"]
  spec.email         = ["275742376@qq.com"]

  spec.summary       = %q{Converts IconFont to OC code.}
  spec.description   = %q{A tool that converts IconFont to OC code automatically.}
  spec.homepage      = "https://github.com/panghaijiao/iftoc"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  
  spec.executables   = spec.files.grep(%r{^bin/iftoc}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
