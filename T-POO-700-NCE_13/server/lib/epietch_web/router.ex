defmodule EpietchWeb.Router do
  use EpietchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {EpietchWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EpietchWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # API routes for User
  scope "/api", EpietchWeb do
    pipe_through :api

    get "/users", UserController, :index
    get "/users/:user_id", UserController, :show
    post "/users", UserController, :create
    put "/users/:user_id", UserController, :update
    delete "/users/:user_id", UserController, :delete
  end

  # API routes for WorkingTime
  scope "/api/workingtimes/:user_id", EpietchWeb do
    pipe_through :api

    get "/", WorkingTimeController, :index
    get "/:id", WorkingTimeController, :show
    post "/", WorkingTimeController, :create
  end
  
  # Additional routes for WorkingTime without :user_id in the path
  scope "/api/workingtimes", EpietchWeb do
    pipe_through :api

    put "/:id", WorkingTimeController, :update
    delete "/:id", WorkingTimeController, :delete
  end

  # API routes for Clock
  scope "/api/clocks/:user_id", EpietchWeb do
    pipe_through :api

    get "/", ClockController, :index
    post "/", ClockController, :create
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:epietch, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: EpietchWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
