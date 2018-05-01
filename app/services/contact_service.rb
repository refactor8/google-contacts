require 'google/apis/people_v1'
require 'google/api_client/client_secrets.rb'

class ContactService
  People = Google::Apis::PeopleV1

  class << self
    def fetch(user:, page_size:, page_token: nil)
      secrets = Google::APIClient::ClientSecrets.new(
        {
          "web" =>
            {
              "access_token" => user.token,
              "refresh_token" => user.refresh_token,
              "client_id" => ENV['GOOGLE_CLIENT_ID'],
              "client_secret" => ENV['GOOGLE_CLIENT_SECRET'],
            }
        }
      )

      service = People::PeopleServiceService.new
      service.authorization = secrets.to_authorization

      response = service.list_person_connections(
        'people/me',
         page_size: page_size,
         page_token: page_token,
         sort_order: ['FIRST_NAME_ASCENDING'],
         person_fields: ['names', 'emailAddresses', 'phoneNumbers']
      )
    end
  end
end
