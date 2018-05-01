class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contacts = Contact.paginate(:page => params[:page], :per_page => Rails.configuration.per_page)
  end

  def pull
    ContactsJob.perform_async(current_user.id, Rails.configuration.page_size)
    respond_to do |format|
      format.js {}
    end
  end
end
