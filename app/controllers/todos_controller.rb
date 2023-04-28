class TodosController < ApplicationController
  def index
    matching_todos = Todo.all

    @list_of_todos = matching_todos.order({ :created_at => :desc })
  end

  def show
    the_id = params.fetch("path_id")

    @the_todo = Todo.where({ :id => the_id })

    render({ :template => "todos/show.html.erb" })
  end

  def create
    @the_todo = Todo.new
    @the_todo.content = params.fetch("query_content")
    @the_todo.user_id = session.fetch(:user_id)
    @the_todo.save
    redirect_to("/")
  end


  def update
    @todo = params.fetch("path_id")
    current_stat = params.fetch("query_status")
    @the_todo.status = current_stat
    @todo.save 
    redirect_to("/")
  end

  def destroy
    the_id = params.fetch("path_id")
    the_todo = Todo.where({ :id => the_id }).at(0)

    the_todo.destroy

    redirect_to("/")
  end
end
