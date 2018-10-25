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
    binding.pry
    new.id = highest_id + 1
    @repository << new
  end


end
