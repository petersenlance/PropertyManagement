defmodule Herald.Router do
  use Herald.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Herald do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/send_message", PageController, :send_message
  end

  # Other scopes may use custom stacks.
  # scope "/api", Herald do
  #   pipe_through :api
  # end
end
