class ApplyJobsController < ApplicationController
    before_action :authorize_request, only: [:create]

    def create
        if @current_user
            @job = Job.find_by(id: params[:job_id], status: true)
            if @job.present?
                @uids = ApplyJob.where(user_id: @current_user.id) 
                puts "job name is" + @job.title
                if @uids.find_by(job_id: params[:job_id])
                    render json: {
                        status: 200,
                        info: "already applied"
                    }
                else
                    @apply = ApplyJob.create({
                        job_id: params[:job_id], 
                        user_id: @current_user.id, 
                        job_title: @job.title,
                        user_name: @current_user.name,
                        status: false
                    })
                    render json: {
                        status: :created
                    }
                end
            else
                render json: {
                    status: 500,
				    info: "Job is inactive."
                }
            end
        else
            render json: { status: 500, info: "Require User login" }
        end
    end

end
