defmodule Herald.Repo.Migrations.AddTenantTable do
  use Ecto.Migration

  def change do
    create table(:tenant) do
      add :first_name, :string, null: false
      add :full_name, :string, null: false
      add :phone_number, :string, null: true
      add :address, :string, null: false
    end
  end
end
