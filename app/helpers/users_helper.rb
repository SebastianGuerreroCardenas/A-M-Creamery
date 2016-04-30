module UsersHelper
  

  #for the assignment from, this functions gets all the possible active employee, that can be used to create an employee
  def get_employees_without_users_options
    Employee.no_users.alphabetical.active.to_a.map{|employee| ["#{employee.name}", employee.id] }
  end

end
