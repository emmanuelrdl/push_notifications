
module Rpush
  module Reflectable
    def reflect(name, *args)
      Rpush.reflection_stack.each do |reflection_collection|
        begin
          reflection_collection.__dispatch(name, *args)
        rescue StandardError => e
          Rpush.logger.error(e)
        end
      end
    end
  end
end

module Rpush
  module Daemon
    module Loggable
      def log_debug(msg)
        Rpush.logger.debug(app_prefix(msg))
      end

      def log_info(msg)
        Rpush.logger.info(app_prefix(msg))
      end

      def log_warn(msg)
        Rpush.logger.warn(app_prefix(msg))
      end

      def log_error(e)
        if e.is_a?(Exception)
          Rpush.logger.error(e)
        else
          Rpush.logger.error(app_prefix(e))
        end
      end

      private

      def app_prefix(msg)
        app = instance_variable_get('@app')
        msg = "[#{app.name}] #{msg}" if app
        msg
      end
    end
  end
end



module Rpush
  module Daemon
    class Delivery
      include Reflectable
      include Loggable

      def mark_retryable(notification, deliver_after, error = nil)
        if notification.fail_after && notification.fail_after < Time.now
          @batch.mark_failed(notification, nil, "Notification failed to be delivered before #{notification.fail_after.strftime('%Y-%m-%d %H:%M:%S')}.")
        else
          if error
            log_warn("Will retry notification #{notification.id} after #{deliver_after.strftime('%Y-%m-%d %H:%M:%S')} due to error (#{error.class.name}, #{error.message})")
          end
          @batch.mark_retryable(notification, deliver_after)
        end
      end

      def mark_retryable_exponential(notification)
        mark_retryable(notification, Time.now + 2**(notification.retries + 1))
      end

      def mark_batch_retryable(deliver_after, error)
        log_warn("Will retry #{@batch.notifications.size} notifications after #{deliver_after.strftime('%Y-%m-%d %H:%M:%S')} due to error (#{error.class.name}, #{error.message})")
        @batch.mark_all_retryable(deliver_after)
      end

      def mark_delivered
        @batch.mark_delivered(@notification)
      end

      def mark_batch_delivered
        @batch.mark_all_delivered
      end

      def mark_failed(error)
        code = error.respond_to?(:code) ? error.code : nil
        @batch.mark_failed(@notification, code, error.to_s)
      end

      def mark_batch_failed(error)
        code = error.respond_to?(:code) ? error.code : nil
        @batch.mark_all_failed(code, error.to_s)
      end
    end
  end
end







module Rpush
  module Daemon
    module Apns
      class Delivery < Rpush::Daemon::Delivery
        def initialize(app, connection, batch)
          @app = app
          @connection = connection
          @batch = batch
        end

        def perform
          @connection.write(batch_to_binary)
          mark_batch_delivered
          describe_deliveries
        rescue Rpush::Daemon::TcpConnectionError => error
          mark_batch_retryable(Time.now + 10.seconds, error)
          raise
        rescue StandardError => error
          mark_batch_failed(error)
          raise
        ensure
          @batch.all_processed
        end

        protected

        def batch_to_binary
          log_info("héhéhéhé")
          payload = ""
          @batch.each_notification do |notification|
            payload << notification.to_binary
          end
          payload
        end

        def describe_deliveries
          @batch.each_notification do |notification|
            log_info("#{notification.id} sent to #{notification.device_token}")
          end
        end
      end
    end
  end
end


