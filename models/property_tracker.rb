require ('pg')

class PropertyTracker

  attr_accessor :address, :value, :number_of_bedrooms, :build
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @build = options['build']
    @id = options['id'].to_i if options['id']
  end

  def PropertyTracker.all()
    db = PG.connect({dbname: 'letting_agents', host: 'localhost'})
    sql = "SELECT * FROM  property_tracker"
    db.prepare("all", sql)
    houses = db.exec_prepared("all")
    db.close
    return houses.map { |house| PropertyTracker.new(house)}
  end

  def save()
    db = PG.connect({dbname: 'letting_agents', host: 'localhost'})
    sql = "INSERT INTO property_tracker
    (address, value, number_of_bedrooms, build)
    VALUES($1, $2, $3, $4)
    RETURNING *"
    values = [@address, @value, @number_of_bedrooms, @build]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close
  end
  # def find_by_id
  def update()
    db = PG.connect({dbname: 'letting_agents', host: 'localhost'})
    sql = "UPDATE property_tracker SET (address, value, number_of_bedrooms, build)
    =($1, $2, $3, $4) WHERE id = $5"
    values = [@address, @value, @number_of_bedrooms, @build, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def PropertyTracker.delete_all()
    db = PG.connect({dbname: 'letting_agents', host: 'localhost'})
    sql = "DELETE FROM property_tracker"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close
  end

  def PropertyTracker.find(id)
    db = PG.connect({dbname: 'letting_agents', host: 'localhost'})
    sql = "SELECT * FROM property_tracker WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    results_array = db.exec_prepared("find", id)
    return nil if results_array.first() == nil
    property_hash = results_array[0]
    found_property = PropertyTracker.new(property_hash)
    return found_property
    db.close
  end

  def PropertyTracker.find_by_address(address)
    db = PG.connect({dbname: 'letting_agents', host: 'localhost'})
    sql = "SELECT * FROM property_tracker WHERE address = $1"
    values = [address]
    db.prepare("find_by_address", sql)
    results_array = db.exec_prepared("find_by_address", address)
    return nil if results_array.first() == nil
    property_hash = results_array[0]
    found_property = PropertyTracker.new(property_hash)
    return found_property
    db.close
  end




end
