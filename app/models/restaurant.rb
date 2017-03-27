class Restaurant
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods
  
  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    location: "TEXT",
    owner_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)  
  attr_reader :id

  def owner
    <<-SQL
      SELECT owners.name FROM owners
      INNER JOIN restaurants ON restaurants.id = owners.restaurant_id
      WHERE owners.restaurant_id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end
end