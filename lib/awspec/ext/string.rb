class String
  def camelize
    Dry::Inflector.new.camelize(self)
  end

  def pluralize
    Dry::Inflector.new.pluralize(self)
  end

  def underscore
    Dry::Inflector.new.underscore(self)
  end

  def demodulize
    Dry::Inflector.new.demodulize(self)
  end
end
