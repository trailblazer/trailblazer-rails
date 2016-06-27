module Trailblazer
  module Logging
    class LogSubscriber < ActiveSupport::LogSubscriber
      def self.runtime=(value)
        Thread.current[:trb_log_runtime] = value
      end

      def self.runtime
        Thread.current[:trb_log_runtime] ||= 0
      end

      def self.reset_runtime
        rt, self.runtime = runtime, 0
        rt
      end

      def run(event)
        log event
      end

      def validate(event)
        log event
      end

      def setup!(event)
        log event
      end

      private

      def log(event)
        self.class.runtime += event.duration
        ::Rails.logger.info color("  #{event.payload[:operation].class.name}##{event.payload[:method]} (#{"%.1f" % event.duration}ms)", YELLOW)
      end
      LogSubscriber.attach_to :trailblazer
    end

    module ControllerRuntime
      extend ActiveSupport::Concern

      protected

      attr_internal :trailblazer_runtime

      def cleanup_view_runtime
        before_render = Trailblazer::Logging::LogSubscriber.reset_runtime
        runtime = super
        after_render = Trailblazer::Logging::LogSubscriber.reset_runtime
        self.trailblazer_runtime = before_render + after_render
        runtime - after_render
      end

      def append_info_to_payload(payload)
        super
        payload[:trailblazer_runtime] = (trailblazer_runtime || 0) + Trailblazer::Logging::LogSubscriber.runtime
      end

      module ClassMethods
        def log_process_action(payload)
          messages, trailblazer_runtime = super, payload[:trailblazer_runtime]
          messages << ("Trailblazer: %.1fms" % trailblazer_runtime.to_f) if trailblazer_runtime
          messages
        end
      end
    end

    ActiveSupport.on_load(:action_controller) do
      include Trailblazer::Logging::ControllerRuntime
    end

    module Instrumentation
      [:setup!, :run].each do |method|
        define_method method do |*args, &block|
          ActiveSupport::Notifications.instrument "#{method}.trailblazer", operation: self, method: method do
            super *args, &block
          end
        end
      end
    end

    Operation.class_eval do
      prepend Trailblazer::Logging::Instrumentation
    end
  end
end
