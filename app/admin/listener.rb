ActiveAdmin.register Listener do
  permit_params :email, :password, :password_confirmation, :time_zone, :recieve_message_at

  index do
  column :id
  column :email
  column :name
  column :Lastname
  column :Organization
  actions
end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
