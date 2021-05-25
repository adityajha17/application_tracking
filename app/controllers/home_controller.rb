class HomeController < ApplicationController
    before_action :authorize_request, only: :user_available_jobs
    before_action :admin_authorize_request, only: :admin_available_jobs
    
    def admin_available_jobs
        if @current_admin
            @jobs = Job.all
			@users = User.all
            @all_applied_jobs = ApplyJob.select("id, user_name, job_title, status, user_id, job_id")

            render json: {
                avilable_jobs: @jobs,
                users: @users,
                all_applied_jobs: @all_applied_jobs
            }
        else
            render json: { status: 500, info: "Require Admin login" }
        end

    end
    def user_available_jobs
        if @current_user
            @jobs = Job.where(status: true)
            @applied_jobs = ApplyJob.select("id, user_name, job_title, status, user_id, job_id").where(job_id: @jobs, user_id: @current_user.id)

            render json: {
                avilable_jobs: @jobs,
                applied_jobs: @applied_jobs
            }
        else
            render json: { status: 500, info: "Require User login" }
        end

    end
    def index
            @jobs = Job.where(status: true)
            render json: {
                jobs: @jobs
            }
        
    end
    
end
