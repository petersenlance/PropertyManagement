defmodule Herald.DB.SQL.Schema.Tenant do
  use Ecto.Schema

  schema "tenant" do
    field :first_name, :string
    field :full_name, :string
    field :phone_number, :string
    field :address, :string
    field :building, :integer
    field :apartment, :integer
  end
end
