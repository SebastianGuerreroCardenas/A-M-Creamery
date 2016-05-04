module ShiftsHelper
  
  def get_assignment_options
    
    Assignment.current.by_store.by_employee.chronological.to_a.map { |assignment| ["#{assignment.store.name}"+ ", " + "#{assignment.employee.name}", assignment.id]  }
  end


  def get_assignment_options_manager(store)
    
    Assignment.current.for_store(store).by_store.by_employee.chronological.to_a.map { |assignment| ["#{assignment.employee.name}", assignment.id]  }
  end


  def get_assignment_for_adding_shift(employee)
    
    Assignment.current.for_employee(employee).by_store.by_employee.chronological.to_a.map { |assignment| ["#{assignment.employee.name}", assignment.id]  }
  end

end
