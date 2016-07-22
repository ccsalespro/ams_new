json.array!(@internal_contacts) do |internal_contact|
  json.extract! internal_contact, :id, :full_name, :phone_number, :email_address, :message
  json.url internal_contact_url(internal_contact, format: :json)
end
