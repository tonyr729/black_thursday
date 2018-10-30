require 'pry'

module BTMethods
  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |repository_element|
      repository_element.id.to_i == id
    end
  end

  def find_by_name(name)
    where(name.downcase, "name")
  end

  def find_all_by_name(name)
    where_any(name, "name")
  end

  def find_all_by_invoice_id(invoice_id)
    where_any(invoice_id, "invoice_id")
  end

  def find_all_by_credit_card_number(credit_card_number)
    where_any(credit_card_number, "credit_card_number")
  end

  def where(value, key)
    result = where_i(value, key) if value.class == Fixnum
    result = where_f(value, key) if value.class == Float
    result = where_s(value, key) if value.class == String
    result = where_r(value, key) if value.class == Range
    result
  end

  def where_i(value, key)
    @repository.find do |repository_element|
      property = repository_element.public_send(key) if repository_element.respond_to? key
      property.to_i == value
    end
  end

  def where_f(value, key)
    @repository.find do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      property.to_f == value
    end
  end

  def where_s(value, key)
    @repository.find do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      property.downcase.include?(value.downcase)
    end
  end

  def where_r(value, key)
    value = value.downcase if value.class == String

    @repository.find do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      value.include?(property.to_i)
    end
  end


  def where_any(value, key)
    # binding.pry
    result = where_any_i(value, key) if value.class == Fixnum
    result = where_any_f(value, key) if value.class == Float || value.class == BigDecimal
    result = where_any_s(value, key) if value.class == String || value.class == Symbol
    result = where_any_r(value, key) if value.class == Range
    result
  end

  def where_any_i(value, key)
    @repository.select do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      property.to_i == value
    end
  end

  def where_any_f(value, key)
    # binding.pry
    @repository.select do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      property.to_f == value.to_f
    end
  end

  def where_any_s(value, key)
    @repository.select do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      property.to_s.downcase.include?(value.to_s.downcase)
    end
  end

  def where_any_r(value, key)
    @repository.select do |repository_element|
      method_name = key
      property = repository_element.public_send(method_name) if repository_element.respond_to? method_name
      value.include?(property)
    end
  end

  def create(attributes)
    if attributes.include?(:updated_at) || attributes.include?(:created_at)
      attributes[:updated_at] = Time.now.to_s
      attributes[:created_at] = Time.now.to_s
    end
    highest_id = @repository.max_by { |x| x.id}.id
    new = @new_instance.new(attributes)
    new.id = highest_id + 1
    @repository << new
  end

  def update(id, attributes)
    return nil if attributes.include?(:id)
    selected_instance = @repository.find { |x| x.id == id}
    keys_as_strings = attributes.map { |k, v| k.to_s }
    replace_value(attributes, selected_instance, keys_as_strings)
    selected_instance
  end

  def replace_value(attributes, selected_instance, keys_as_strings)
    keys_as_strings.each do |method|
      if selected_instance.send(method).class == String
      selected_instance.send(method).replace attributes[method.to_sym]
      else
        selected_instance.send("#{method}=", attributes[method.to_sym])
      end
      if selected_instance.class.method_defined?(:updated_at)
        selected_instance.updated_at = Time.now
      end
    end
  end

  def delete(id)
  @repository.delete_if do |repository_element|
    repository_element.id == id
    end
  end

end
