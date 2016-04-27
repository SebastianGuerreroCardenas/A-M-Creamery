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

      # they can read only employees who are in their store
      can :read, Employee do |this_employee| 
         unless user.employee.current_assignment.nil? do
            my_store_id = user.employee.current_assignment.store.id
            if not employee.current_assignment.current_assignment.nil?
                my_store_id == employee.current_assignment.store.id
            end
         end
      end

      # can see a list of all users
      can :index, User
      
      # they can read their own profile
      can :show, User do |u|  
        u.id == user.id
      end
      # they can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end
      
      # they can read their own projects' data
      can :read, Project do |this_project|  
        my_projects = user.projects.map(&:id)
        my_projects.include? this_project.id 
      end
      # they can create new projects for themselves
      can :create, Project
      
      # they can update the project only if they are the manager (creator)
      can :update, Project do |this_project|
        managed_projects = user.projects.map{|p| p.id if p.manager_id == user.id}
        managed_projects.include? this_project.id
      end
            
      # they can read tasks in these projects
      can :read, Task do |this_task|  
        project_tasks = user.projects.map{|p| p.tasks.map(&:id)}.flatten
        project_tasks.include? this_task.id 
      end
      
      # they can update tasks in these projects
      can :update, Task do |this_task|  
        project_tasks = user.projects.map{|p| p.tasks.map(&:id)}.flatten
        project_tasks.include? this_task.id 
      end
      
      # they can create new tasks for these projects
      can :create, Task do |this_task|  
        my_projects = user.projects.map(&:id)
        my_projects.include? this_task.project_id  
      end

    elsif user.role? :employee
      # can see a list of all users
      can :index, User
      
      # they can read their own profile
      can :show, User do |u|  
        u.id == user.id
      end
      # they can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end
      
      # they can read their own projects' data
      can :read, Project do |this_project|  
        my_projects = user.projects.map(&:id)
        my_projects.include? this_project.id 
      end
      # they can create new projects for themselves
      can :create, Project
      
      # they can update the project only if they are the manager (creator)
      can :update, Project do |this_project|
        managed_projects = user.projects.map{|p| p.id if p.manager_id == user.id}
        managed_projects.include? this_project.id
      end
            
      # they can read tasks in these projects
      can :read, Task do |this_task|  
        project_tasks = user.projects.map{|p| p.tasks.map(&:id)}.flatten
        project_tasks.include? this_task.id 
      end
      
      # they can update tasks in these projects
      can :update, Task do |this_task|  
        project_tasks = user.projects.map{|p| p.tasks.map(&:id)}.flatten
        project_tasks.include? this_task.id 
      end
      
      # they can create new tasks for these projects
      can :create, Task do |this_task|  
        my_projects = user.projects.map(&:id)
        my_projects.include? this_task.project_id  
      end

    else
      # guests can only read domains covered (plus home pages)
      can :read, Domain
    end

#MANAGERS:
#can read any information on stores, jobs, flavors.
#can read employee and assignment information for employees who are currently assigned to the same store the manager is currently assigned to.
#can read shift information for employees who are currently assigned to the same store the manager is currently assigned to.
#can create new shifts for (1) the same store the manager is currently assigned to and for (2) employees currently assigned to same store.
#can update or destroy shifts that are associated with the same store as the manager's currently assigned store.
#can create and destroy shift-jobs for shifts that are associated with the same store as the manager's currently assigned store.
#can create and destroy store-flavors for the same store the manager is currently assigned to.

#Employees
# read any information on stores, as well as jobs and flavors (stores required, but jobs and flavors are optional).
# can read employee, user, assignment and shift and shift-job information that belongs to them directly.
# can update their own employee and user data, with the exception of SSN (this latter requirement not to be handled in the ability.rb file).



  end
end
