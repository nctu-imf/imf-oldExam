class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_search_key, :only => [:search]

  # GET /courses/new
  def new
    @course = Course.new
    authorize! :create, @course
  end

  def dashboard
    @courses = Course.order("created_at DESC").paginate(:per_page => 12, :page => params[:page])

    authorize! :manage, @course
  end

  # GET /courses/1/edit
  def edit
    find_course_and_check_is_admin?

    authorize! :update, @course
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = current_user.courses.new(course_params)

    respond_to do |format|
      if @course.save
        # format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.html { redirect_to grade_path(@course.grade_id), notice: '課程已成功新增！' }
        format.json { render :index, status: :created, location: @courses }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end

    authorize! :create, @course
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    find_course_and_check_is_admin?

    if @course.update(course_params)
      redirect_to grade_path(@course.grade_id), notice: '課程已修改成功'
    else
      render :new
    end

    authorize! :update, @course
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    find_course_and_check_is_admin?

    @course.destroy
    respond_to do |format|
      # format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.html { redirect_to grade_path(@course.grade_id), notice: '已刪除該課程檔案。' }
      format.json { head :no_content }
    end

    authorize! :destroy, @course
  end

  def download_file
    @course = Course.find(params[:id])
    send_file(@course.data.path,
              :disposition => 'attachment',
              :url_based_filename => false)
  end

  def search
    if @query_string.present?
      @courses = Course.ransack(@search_criteria).result(:distinct => true)
    end
  end

  protected

  # 處理params[:q]拿到的資料，把特殊字元拿掉
  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end

  # 告訴controller我們要找的資料範圍
  def search_criteria(query_string)
    { :name_or_teacher_cont => query_string }
  end

  private

    def find_course_and_check_is_admin?
      if current_user.admin?
        @course = Course.find(params[:id])
      else
        @course = current_user.courses.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :category, :year, :grade_id, :teacher, :note, :data, :semester_id)
    end
end
