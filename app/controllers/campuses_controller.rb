class CampusesController < ApplicationController
  def campuses
    @json = Campus.all.select {|x| x.is_confirmed? }

    render json: @json, :only => [:name_eng, :name_kor, :name_kor_short, :email]
  end
end
