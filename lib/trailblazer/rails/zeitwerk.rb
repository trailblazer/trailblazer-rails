require "trailblazer/activity/dsl/linear/zeitwerk"

Trailblazer::Operation.extend(Trailblazer::Activity::DSL::Linear::Zeitwerk::Strategy)

Rails.autoloaders.main.on_load do |_cpath, value, _abspath|
  if value < Trailblazer::Operation
    puts "==> #{value}"

    value.finalize! # compile the {Activity}.
  end
end
