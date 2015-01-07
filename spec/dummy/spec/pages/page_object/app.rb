module PageObject
  class NoPageError < NameError
    def initialize(meth)
      super "Please define #{meth.to_s.classify} that includes PageObject::BasePage."
    end
  end

  class App
    def method_missing(meth, *args, &block)
      if meth.match /.*_page/
        klass = meth.to_s.classify
        if Object.const_defined? klass
          klass.constantize.new
        else
          raise NoPageError.new(meth)
        end
      else
        super
      end
    end
  end
end
