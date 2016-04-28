module AssignmentsHelper
  
  #for the assignment from, this function gets all the possible active stores, that can be used to create a 
  # an assignent
  def get_store_options
    Store.alphabetical.active.to_a.map{|store| ["#{store.name}", store.id] }
  end

  #for the assignment from, this functions gets all the possible active employee, that can be used to create an employee
  def get_employee_options
    Employee.alphabetical.active.to_a.map{|employee| ["#{employee.name}", employee.id] }
  end

end
