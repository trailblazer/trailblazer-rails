source 'https://rubygems.org'

# Specify your gem's dependencies in trailblazer-rails.gemspec
gemspec

case ENV['GEMS_SOURCE']
  when 'local'
    gem "cells-erb", path: "../cells-erb"
    gem "cells-rails", path: "../cells-rails"
    gem "reform-rails", path: "../reform-rails"
    gem "trailblazer", path: "../trailblazer"
    gem "trailblazer-cells", path: "../trailblazer-cells"
    gem "trailblazer-loader", path: "../trailblazer-loader"
  when 'github'
    gem "cells-erb", github: "trailblazer/cells-erb"
    gem "cells-rails", github: "trailblazer/cells-rails"
    gem "reform-rails", github: "trailblazer/reform-rails"
    gem "trailblazer", github: "trailblazer/trailblazer"
    gem "trailblazer-cells", github: "trailblazer/trailblazer-cells"
    gem "trailblazer-loader", github: "trailblazer/trailblazer-loader"
  when 'custom'
    eval_gemfile('GemfileCustom')
  else # use rubygems releases
    gem "cells-erb"
    gem "cells-rails"
    gem "reform-rails"
    gem "trailblazer"
    gem "trailblazer-cells"
    gem "trailblazer-loader"
end
