class Api::V1::ProctorController < ApplicationController
  
  def index
    proctors = Proctor.all
    render json: proctors, status: 200
  end

  def create
    proctor = Proctor.new(
      first_name: proc_params[:first_name],
      last_name: proc_params[:last_name],
      phone_number: proc_params[:phone_number],
      college_id: proc_params[:college_id],
      exam_id: proc_params[:exam_id],
      start_time: proc_params[:start_time]
    )
    if proctor.save
      render json: proctor, status: 200
    else
      render json: proctor, status: 400
    end
  end

  def show
    proctor = Proctor.find_by(id: params[:id])
    if proctor
      render json: proctor, status: 200
    else
      render json: {error: "Exam not found."}
    end
  end

  def destroy
    proctor = Proctor.find_by(id: params[:id])
    proctor.destroy
    if proctor
      render json: proctor, status: 200
    else
      render json: {error: "Could not delete."}
    end
  end

  def update
    proctor = Proctor.find_by(id: params[:id])
    if proctor.update_attributes(proc_params)
      if proctor
        render json: proctor, status: 200
      else
        render json: {error: "Could not update."}
      end
  end

  private
    def proc_params
      params.require(:proctor).permit([
        :first_name,
        :last_name,
        :phone_number,
        :college_id,
        :exam_id,
        :start_time 
      ])
    end
end
