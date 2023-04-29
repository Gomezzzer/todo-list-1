class TodosController < ApplicationController
  def index
    matching_todos = Todo.all

    @list_of_todos = matching_todos.order({:created_at => :desc})
  end

 
  def create
    # Create a new instance of the Todo model
    @the_todo = Todo.new
  
    # Set the content of the @the_todo object to the value of "query_content" from the request parameters
    @the_todo.content = params.fetch("query_content")
  
    # Set the user_id of the @the_todo object to the value retrieved from the session with the key :user_id
    @the_todo.user_id = session.fetch(:user_id)
  
    # Save the @the_todo object to the database
    @the_todo.save
  
    # Redirect the user to the root path ("/")
    redirect_to("/")
  end

 #  Explanation of the above code 
 #  It initializes a new instance of the Todo model and assigns it to the @the_todo instance variable.
 #  It sets the content of the @the_todo object to the value of the "query_content" parameter retrieved from the request parameters.
 #  It sets the user_id of the @the_todo object to the value retrieved from the session with the key :user_id.
 #  It saves the @the_todo object to the database, persisting the new Todo item.
 #  It redirects the user to the root path ("/").

  def show
    the_id = params.fetch("path_id")

    @the_todo = Todo.where({:id => the_id})

    render({ :template => "todos/show.html.erb" })
  end


  def update
    # Find the Todo object based on the value of `params[:path_id]`
    @todo = Todo.find(params[:path_id])
  
    # Get the current status from the request parameters with the key "query_status"
    current_stat = params.fetch("query_status")
  
    # Update the status of the @todo object with the value of current_stat
    @todo.status = current_stat
  
    # Save the changes made to the @todo object in the database
    @todo.save
  
    # Redirect the user to the root path ("/")
    redirect_to("/")
  end

  def destroy
    the_id = params.fetch("path_id")
    the_todo = Todo.where({id: the_id}).at(0)

    the_todo.destroy

    redirect_to("/")
  end
end
