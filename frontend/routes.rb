# ead transform routes
ArchivesSpace::Application.routes.draw do
  match 'resources/:id/csv' => 'resources_ead_xform#csv', :via => [:get, :post]
end
