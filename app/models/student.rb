class Student

  def self.all
    CODELAB_STUDENTS.map do |student_data|
      Student.new(student_data)
    end
  end

  attr_reader :name, :username

  def initialize data
    data.keys.each do |key|
      instance_variable_set "@#{key}", data[key]
    end
  end

  def image_path
    ActionController::Base.helpers.image_path(image_filename)
  end

  def user
    @user ||= User.find_by(username: @username)
  end

  def to_hash
    hash = {}
    instance_variables.each do |var|
      hash[var.to_s.delete('@')] = instance_variable_get(var)
    end
    hash.merge({
      user: user,
      image_path: image_path
    })
  end

  def to_json
    to_hash.to_json
  end

private

  def image_filename
    @name.downcase.gsub(/\s+/, '-') + '.jpg'
  end

end
