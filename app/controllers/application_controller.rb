class ApplicationController < ActionController::API
end

class Array
  def paginate(page: 1, per_page: 10)
    offset = (page - 1) * per_page
    self[offset, per_page] || []
  end
end
