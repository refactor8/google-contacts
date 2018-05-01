class ContactsJob
  include SuckerPunch::Job

  def perform(user_id, page_size)
    ActiveRecord::Base.connection_pool.with_connection do
      user = User.find(user_id)

      page_token = nil
      people_connections = Enumerator.new do |yielder|
        loop do
          result = ContactService.fetch(user: user, page_size: page_size,
            page_token: page_token)
          page_token = result.next_page_token
          yielder.yield result.connections
          break unless page_token
        end
      end

      save(people_connections)
    end
  end

  def save(people_connections)
    people_connections.each do |connections|
      connections.each do |connection|
        name = connection.names.first.display_name if connection.names
        email = connection.email_addresses.first.value if connection.email_addresses
        phone = connection.phone_numbers.first.value if connection.phone_numbers
        Contact.find_or_create_by(name: name, email: email, phone: phone)
      end
    end
  end
end
