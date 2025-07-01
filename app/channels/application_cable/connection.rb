module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def session_id
      @request.session.id.to_s
    end
  end
end
