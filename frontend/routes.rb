# ead transform routes
ArchivesSpace::Application.routes.draw do
  match 'resources/:id/staff_csv' => 'resources_ead_xform#staff_csv', :via => [:get, :post]
end
