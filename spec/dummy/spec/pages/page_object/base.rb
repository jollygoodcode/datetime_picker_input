require 'addressable/template'

module PageObject
  class NoUrl        < StandardError; end
  class NoUrlMatcher < StandardError; end

  DEFAULT_WAIT_SECONDS = 5

  module Base
    include Capybara::DSL

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def has_url(url)
        @url = url
      end

      def matches(url_matcher)
        @url_matcher = url_matcher
      end

      def element(identifier)
        define_method identifier.to_s do
          find "[data-id-for-spec=#{identifier}]"
        end
      end

      def elements(identifier)
        define_method identifier.to_s do
          all "[data-id-for-spec=#{identifier}]"
        end
      end
    end

    def page
      Capybara.current_session
    end

    def visit_url(parameters={})
      raise PageObject::NoUrl, 'Please add has_url method with corresponding url of that page to your page object (#{self.class.to_s}).' if url.nil?
      visit Addressable::Template.new(url).expand(parameters).to_s
    end

    def current?
      raise PageObject::NoUrlMatcher, "Please add matches method with corresponding url regexp of that page to your page object (#{self.class.to_s})." if url_matcher.nil?
      wait_until do
        !(page.current_url =~ url_matcher).nil?
      end
    end

    private

      def url
        self.class.instance_variable_get(:@url)
      end

      def url_matcher
        self.class.instance_variable_get(:@url_matcher)
      end

      def wait_until(wait_seconds = DEFAULT_WAIT_SECONDS)
        start_time = Time.current
        loop do
          return true if yield
          break unless Time.current - start_time <= wait_seconds
          sleep(0.05)
        end
        raise 'Timed out!'
      end
  end
end
