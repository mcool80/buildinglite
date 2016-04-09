class StaticController < ApplicationController
  before_action :set_globals

  def index
    skip_authorization
    @fees = Fee.where(community_id: $current_community.id)
  end
end
