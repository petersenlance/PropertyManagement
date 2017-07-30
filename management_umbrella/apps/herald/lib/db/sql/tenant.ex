defmodule Herald.DB.SQL.Tenant do
  alias Herald.DB.SQL.Schema.Tenant
  alias Herald.Repo
  import Ecto.Query

  @required ~w(
    first_name
    full_name
    address
    building
 )a

 @optional ~w(
    phone_number
    apartment
  )a

  def changeset(params \\ %{}, tenant) do
    tenant
    |> Ecto.Changeset.cast(params, @required ++ @optional)
    |> Ecto.Changeset.validate_required(@required)
  end

  def get_all() do
    query = from t in Tenant,
      select: {t}
    Repo.all(query) |> _unwrap()
  end

  def get_big_lot() do
    query = from t in Tenant,
      select: {t},
      where: t.building != ^706 and t.building != 1
    Repo.all(query) |> _unwrap()
  end

  def get_by_id(id) do
    query = from t in Tenant,
      select: {t},
      where: t.id == ^id
    Repo.one(query)
  end

  def get_by_building(building) do
    query = from t in Tenant,
      select: {t},
      where: t.building == ^building
    Repo.all(query) |> _unwrap()
  end

  defp _unwrap(result) do
    case length(result) do
      0 ->
        result
      _ ->
        Enum.map(result, fn(tenant) -> elem(tenant, 0) end)
    end
  end
end
