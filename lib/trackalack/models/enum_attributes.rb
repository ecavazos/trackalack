module EnumAttributes
  def enum_attr(name)
    define_getter(name)
    define_setter(name)
    define_display(name)
  end

  private

  def define_getter(name)
    define_method(name) do
      v = read_attribute(name)
      (v.nil?)? v : v.to_sym
    end
  end

  def define_setter(name)
    define_method("#{name}=") do |value|
      write_attribute(name, value.to_s)
    end
  end

  # defines a method that will get the string value
  # from the list of lookups
  # SomeTypes.all[:sym]
  def define_display(name)
    define_method("#{name}_display") do
      type_constant = name.to_s.camelize.pluralize.constantize
      sym = self.send(name)
      (sym)? type_constant.all[sym] : ''
    end
  end
end
