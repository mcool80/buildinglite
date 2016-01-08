class StaticController < ApplicationController
  def index
	current_apartment = Apartment.find(current_user.apartment_id)
	@fees = Fee.where(community_id: current_apartment.community_id)
	@current_community = Community.find(current_apartment.community_id)
  end
end
