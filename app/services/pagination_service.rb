class PaginationService
  def self.paginate(user:, service:, page_size:)
    page_token = nil
    Enumerator.new do |yielder|
      loop do
        result = service.class.fetch(user: user, page_size: page_size,
          page_token: page_token)
        page_token = result.next_page_token
        yielder.yield result
        break unless page_token
      end
    end
  end
end
