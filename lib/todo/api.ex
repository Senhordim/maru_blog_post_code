defmodule Todo.Api do
  use Maru.Router

  namespace :tasks do
    desc "get all tasks"
    get do
      %{ tasks: "All tasks" } |> json
    end

    desc "get a task by id"
    route_param :id do
      get do
        %{ task: params[:id] } |> json
      end
    end

    desc "creates a task"
    params do
      requires :description, type: String
      requires :completed, type: Boolean
    end
    post do
      %{description: params[:description], completed: params[:completed], operation: "create"} |> json
    end

    desc "updates a task"
    params do
      requires :id, type: Integer
      optional :completed, type: Boolean
      optional :description, type: String
      at_least_one_of [:completed, :description]
    end
    put do
      %{id: params[:id], description: params[:description], completed: params[:completed], operation: "update"} |> json
    end

    desc "deletes a task"
    params do
      requires :id, type: Integer
    end
    delete do
      %{id: params[:id]} |> json
    end

  end

  def error(conn, _e) do
    %{error: _e} |> json
  end
end
