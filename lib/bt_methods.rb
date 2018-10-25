module BTMethods
  def all
    @repository
  end

  def find_by_id(value, key = "id")
    @repository.find do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      property == value
    end
  end
  
  def find_by_name(name)
    where(name, "name")
  end

  def find_all_by_name(name)
    where_any(name, "name")
  end

  def where(value, key)
    @repository.find do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      property == value
    end
  end

  def where_any(value, key)
    result = where_any_i(value, key) if value.class == Fixnum
    result = where_any_f(value, key) if value.class == Float
    result = where_any_s(value, key) if value.class == String
    result = where_any_r(value, key) if value.class == Range
    result
  end
  
  def where_any_i(value, key)
    @repository.select do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      property == value
    end
  end
  
  def where_any_f(value, key)
    @repository.select do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      property.to_f == value
    end
  end

  def where_any_s(value, key)
    @repository.select do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      # require 'pry'; binding.pry
      property.downcase.include?(value.downcase)
    end
  end

  def where_any_r(value, key)
    value = value.downcase if value.class == String

    @repository.select do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      value.include?(property)
    end
  end
  
end
