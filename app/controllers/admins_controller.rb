class AdminsController < ApplicationController
 
    def generate_otp
      
        if  params[:mobile].to_i > 6000000000 && params[:mobile].to_i < 9999999999
          @number = params[:mobile]
          admin = Admin.find_by("mobile = #@number")
          if admin
          @otp = rand(111111..999999)
          # puts @otp
          # @number = params[:mobile]

          puts "mobile number #@number"
        #   admin = Admin.new
          admin.otp = @otp
          
          if admin.save
            render json: admin, status: :created
          else
            render json: { errors: admin.errors.full_messages },
                   status: :unprocessable_entity
          end
        else
          render json: {
            status: 500,
            info: "Enter admin mobile number"
        }
        end
      else
        render json: {
            status: 500,
            info: "Enter correct mobile number"
        }
      end
  
    
    end
  
  
  
  
    def verify_otp
      admin = Admin.find_by(mobile: params[:mobile]) 
      
      puts admin.otp
      puts admin.mobile
      
        @otp2 = admin.otp
        puts @otp2
  
        params_otp = params[:otp].to_s
  
      if @otp2 == params[:otp].to_i
        @number1 =  admin.mobile
        @number = nil
        token = JWebToken.encode(
                                 admin_id: admin.id,
                                 mobile: admin.mobile)
        time = Time.now + 24.hours.to_i
              render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                name: admin.name }
          
        
      else
        render json: {
            status: "Wrong OTP"
        }
      end
  
    end

  
    private
  
    def admin_params
      params.permit(:mobile, :otp)
    end
  end
  
  
  
  