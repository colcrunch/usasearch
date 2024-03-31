defmodule UsasearchWeb.ErrorJSONTest do
  use UsasearchWeb.ConnCase, async: true

  test "renders 404" do
    assert UsasearchWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert UsasearchWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
