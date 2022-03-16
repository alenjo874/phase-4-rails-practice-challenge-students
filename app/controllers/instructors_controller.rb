class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
    rescue_from ActiveRecord::RecordNotFound, with: :handle_notfound

    def index
    instructors = Instructor.all
        render json: instructors
    end

    def show
    instructor_id = Instructor.find_by!(id:params[:id])
        render json: instructor_id
    end

    def create
        new_instructor = Instructor.create!(instructor_params)
        render json: new_instructor
    end


    def update
        update_instructor = Instructor.find_by!(id:params[:id])
        update_instructor.update(instructor_params)
        render json: update_instructor
    end

    def destroy
        delete_instructor = Instructor.find_by!(id:params[:id])
        delete_instructor.destroy
        render json: {}
    end

    private
    def instructor_params
        params.permit(:name)
    end

    def handle_invalid_record(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end

    def handle_notfound
        render json: {error: "record not found"}, status: :not_found
    end

end
