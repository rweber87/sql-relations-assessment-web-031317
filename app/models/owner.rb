class Owner
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods
  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
  }

  attr_accessor(*self.public_attributes)  
  attr_reader :id

  def restaurants
    <<-SQL
      SELECT restaurants.* FROM restaurants
      INNER JOIN restaurants ON restaurants.owner_id = owners.id
      WHERE restaurants.owner_id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end
end