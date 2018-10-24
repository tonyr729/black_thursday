module BTMethods
  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |repository_element|
      repository_element.id == id
    end
  end
  
  def find_by_name(name)
    where(name, "name")
  end

  def where(value, key)
    @repository.find do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      property == value
    end
  end

  
end
