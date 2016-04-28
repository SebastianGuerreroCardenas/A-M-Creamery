class Ability
  include CanCan::Ability

  def initialize(user)

    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    if user.role? :admin
      # they get to do it all
      can :manage, :all
    elsif user.role? :manager
      #can read store, job and flavor
      can :read, Store
      can :read, Job
      can :read, Flavor
      # # they can read only employees who are in their store
      can :read, Employee do |this_employee| 
         #checks that the current manger has an assignment
         unless user.employee.current_assignment.nil?
            my_store_id = user.employee.current_assignment.store.id
            #checks that the employee has an assingment
            if not this_employee.current_assignment.current_assignment.nil?
                my_store_id == this_employee.current_assignment.store.id
            end
         end
      end
      # # they can read only employees who are in their store
      can :manage, Shift do |this_shift| 
         #checks that the current manger has an assignment
         unless user.employee.current_assignment.nil? 
            my_store_id = user.employee.current_assignment.store.id
            my_store_id == this_shift.store.id
         end
      end
    elsif user.role? :employee
      #can read store, job and flavor
      can :read, Store
      can :read, Job
      can :read, Flavor
      
      # they can read their own profile
      can :show, User do |u|  
        u.id == user.id
      end
      # they can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end

      # they can read their own assignments
      can :read, Assignment do |a|  
        a.employee_id == user.id
      end

      # they can read their own assignments
      can :read, Shift do |s|  
        s.employee.id == user.id
      end

    else
      # guests can only read active stores
      can :read, Store do |s|  
        s.active == true
      end
    end
  end
end
