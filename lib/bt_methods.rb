module BTMethods
  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |repository_element|
      repository_element.id == id
    end
  end

  def create(attributes)
    highest_id = @repository.max_by { |x| x.id}.id
    new = @new_instance.new(attributes)
    new.id = highest_id + 1
    @repository << new
  end

  def update(id, attributes)
    selected_instance = @repository.find { |x| x.id == id}
    keys_as_strings = attributes.map { |k, v| k.to_s }
    replace_value(attributes, selected_instance, keys_as_strings)
    selected_instance
  end

  def replace_value(attributes, selected_instance, keys_as_strings)
    keys_as_strings.each { |method|
      if selected_instance.send(method).class == String
      selected_instance.send(method).replace attributes[method.to_sym]
      else
        selected_instance.send("#{method}=", attributes[method.to_sym])
      end
    }
  end

  def delete(id)
  @repository.delete_if do |repository_element|
    repository_element.id == id
    end
  end

end
