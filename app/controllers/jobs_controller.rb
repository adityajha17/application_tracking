class JobsController < ApplicationController
    before_action :admin_authorize_request, only: [:create_job, :edit_job_status, :available_job, :update_user_status]

    def available_job
        if @current_admin
            @jobs = Job.all
            @users = User.all
            render json: {
				Available_jobs: @jobs,
				Users: @users
				# all_applied_jobs: @all_applied_jobs
			} 

        else
            render json: { status: 500, info: "Require Admin login" }
        end
    end

    def create_job
        if @current_admin
            @job = Job.new(jobs_param)
            if @job.save
                render json: @job, status: :created
            else
                render json: { errors: @job.errors.full_messages },
                status: :unprocessable_entity
            end
        else
            render json: { status: 500, info: "Require Admin login" }
        end
    end

    def edit_job_status
        if @current_admin
            @job = Job.find_by(id: params[:id])
            if @job.present?
               if @job.update(edit_status)
                render json: {status: 200, info: :status_changed, job: @job }
               else
                render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
               end

            else
                render json: { status: 404, info: "Requirement is not available" }
            end
        else
            render json:  { error: 'unauthorized' }, status: :unauthorized
        end
    end

    def update_user_status
        if @current_admin
            puts "admin"
            @usr = ApplyJob.find_by(job_id: params[:job_id], user_id: params[:user_id])
            if @usr.present?
                if @usr.update(user_job_status)
                    @status = ApplyJob.find_by(job_id: params[:job_id], user_id: params[:user_id])
                    if @status == true
                        render json: {
							status: 200,
							info: "User Selected, Email Sent Successfully."
						}
                    else
                        render json: {
							status: 200,
							info: :status_changed
						}
                    end
                else
                    render json: { errors: @usr.errors.full_messages },
               status: :unprocessable_entity
                end
            else
                render json: {
					status: 500,
					info: "jobs is not available for this User"
				}
            end
        else
            render json:  { error: 'unauthorized' }, status: :unauthorized
        end
    end

    private
    def jobs_param
        params.permit(:title, :description, :category, :exp, :status)
    end
    def edit_status
		params.permit(:status)
	end
    def user_job_status
        params.permit(:status)
    end

end
