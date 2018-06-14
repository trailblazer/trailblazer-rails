source 'https://rubygems.org'

# Specify your gem's dependencies in trailblazer-rails.gemspec
gemspec

case ENV['GEMS_SOURCE']
when 'local'
  gem "reform-rails", path: "../reform-rails"
  gem "trailblazer", path: "../trailblazer"
  gem "trailblazer-loader", path: "../trailblazer-loader"
  gem "trailblazer-cells", path: "../trailblazer-cells"
  gem "cells-rails", path: "../cells-rails"
  gem "cells-erb", path: "../cells-erb"
when 'github'
  gem "reform-rails", github: "trailblazer/reform-rails"
  gem "trailblazer", github: "trailblazer/trailblazer"
  gem "trailblazer-loader", github: "trailblazer/trailblazer-loader"
  gem "trailblazer-cells", github: "trailblazer/trailblazer-cells"
  gem "cells-rails", github: "trailblazer/cells-rails"
  gem "cells-erb", github: "trailblazer/cells-erb"
when 'custom'
  eval_gemfile('GemfileCustom')
else # use rubygems releases
  gem "reform-rails"
  gem "trailblazer"
  gem "trailblazer-loader"
  gem "trailblazer-cells"
  gem "cells-rails"
  gem "cells-erb"
end
