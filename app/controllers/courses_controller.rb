class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :download_file]
  before_action :authenticate_user!  

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        # format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.html { redirect_to @course, notice: '課程已成功新增！' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        # format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.html { redirect_to @course, notice: '修改成功！' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      # format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.html { redirect_to courses_url, notice: '已刪除該課程檔案。' }
      format.json { head :no_content }
    end
  end

  def download_file
      send_file(@course.CourseData.path,
                :disposition => 'attachment',
                :url_based_filename => false) 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :category, :year, :grade_id, :teacher, :note, :CourseData)
    end
end
