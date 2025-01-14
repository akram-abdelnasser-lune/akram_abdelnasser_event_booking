ActiveAdmin.register User do
  permit_params :email, :name, :password

  filter :email
  filter :name
  filter :created_at
  
  index do
    selectable_column
    id_column
    column :email
    column :name
    column :created_at
    column :last_sign_in_at
    actions
  end
end
