module Sunny
  module ArrayPatch
    def to_h(&block)
      ary = block_given? ? self.collect(&block) : self
      Hash[*ary.flatten]
    end
  end

  module HashPatch
    def to_h(&block)
      return self if !block_given?
      Hash[*self.collect(&block).flatten]
    end
  end
end

Array.send :include, Sunny::ArrayPatch
Hash.send  :include, Sunny::HashPatch

