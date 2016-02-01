class StaffMember

  class << self

    def all
      CODELAB_STAFF.map do |member_data|
        StaffMember.new(member_data)
      end
    end

    def method_missing method_name
      all.select do |member|
        member.roles.map(&:downcase).include?(
          method_name.to_s.downcase.singularize
        )
      end
    end

  end

  attr_reader :name, :bio, :tech, :contact_methods, :roles

  def initialize data
    data.keys.each do |key|
      instance_variable_set "@#{key}", data[key]
    end
  end

  def username
    @contact_methods.find do |method|
      method['type'] == 'GitHub'
    end['body']
  end

  def image_path
    ActionController::Base.helpers.image_path(image_filename)
  end

  def to_hash
    hash = {}
    instance_variables.each do |var|
      hash[var.to_s.delete('@')] = instance_variable_get(var)
    end
    hash.merge({
      username: username,
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
