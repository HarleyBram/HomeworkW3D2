require('pry')
require_relative('models/property_tracker.rb')


PropertyTracker.delete_all()

property1 = PropertyTracker.new({
  'address' => '1 baker street',
  'value' => '50_000',
  'number_of_bedrooms' => '2',
  'build' => 'apartment'
})

property2 = PropertyTracker.new({
  'address' => '5 notbaker street',
  'value' => '73_010',
  'number_of_bedrooms' => '3',
  'build' => 'terraced'
})

property3 = PropertyTracker.new({
  'address' => '20 drury lane',
  'value' => '250_000',
  'number_of_bedrooms' => '4',
  'build' => 'detached',
})

property1.save
property2.save
property3.save

property2.value = 1000000
PropertyTracker.find(15)



property2.update()







binding.pry
nil
