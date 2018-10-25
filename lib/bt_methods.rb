module BTMethods
  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |repository_element|
      repository_element.id == id
    end
  end

  def delete(id)
  @repository.delete_if do |repository_element|
    repository_element.id == id
    end
  end

end
