Gem::Specification.new do |s|
  s.name          = 'pretty_inspect'
  # when changing version, also change the lib/pretty_inspect.rb
  s.version       = '1.4.0'
  s.date          = '2019-10-10'
  s.summary       = "Pretty Inspect (pretty_inspect) is an extension to Object::inspect."
  s.description   = "Pretty Inspect can be used anywhere Object::inspect can be used, and produces a more human readable representation of the object.\n
 It can be called as:\n
  object.pretty_inspect\n
  object.pretty_inspect(n), where n is the maximum depth to display"
  s.authors       = ["Michael J. Welch, Ph.D."]
  s.email         = 'mjwelchphd@gmail.com'
  s.files         = [ "lib/pretty_inspect.rb" ]
  s.require_paths = ["lib"]
  s.homepage      = 'http://rubygems.org/gems/pretty_inspect'
  s.license       = 'Ruby'
end
