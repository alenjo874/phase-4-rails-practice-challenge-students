class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
    rescue_from ActiveRecord::RecordNotFound, with: :handle_notfound

    def index
        students = Student.all 
        render json: students
    end

    def show
        student_id = Student.find_by!(id: params[:id])
        render json: student_id
    end

    def create
        create_student = Student.create!(student_params)
        render json: create_student
    end

    def update 
        update_student = Student.find_by!(id: params[:id])
        update_student.update!(student_params)
        render json: update_student
    end

    def destroy 
        destroy_student = Student.find_by!(id: params[:id])
        destroy_student.destroy
    end

    private 

    def student_params 
        params.permit(:name, :major, :age, :instructor_id)
    end

    def handle_invalid_record(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end

    def handle_notfound 
        render json: {error: "record not found"}, status: :not_found
    end

end
