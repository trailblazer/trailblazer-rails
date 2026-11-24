# Trailblazer::Activity::FastTrack.Compiler___Fixme = Trailblazer::Activity::DSL::Linear::Sequence::Compiler

require "trailblazer/activity/dsl/linear/zeitwerk"

Trailblazer::Operation.extend(Trailblazer::Activity::DSL::Linear::Zeitwerk::Strategy)

Rails.autoloaders.main.on_load do |_cpath, value, _abspath|
  if value.is_a?(Class) && value < Trailblazer::Operation
    # puts "==> #{value}"

    value.finalize! # compile the {Activity}.
  end
end
