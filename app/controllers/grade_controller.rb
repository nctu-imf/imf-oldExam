class GradeController < ApplicationController
  before_action :authenticate_user!  
  
  def show
    @grades = Grade.all
    @grade = Grade.find(params[:id])
    @courses = @grade.courses.recent
  end

  # def download_courses_as_zip
  #   generate_zip do |zipname, zip_path|
  #     File.open(zip_path, 'rb') do |zf|
  #       # you may need to set these to get the file to stream (if you care about that)
  #       # self.last_modified
  #       # self.etag
  #       # self.response.headers['Content-Length']
  #       self.response.headers['Content-Type'] = "application/zip"
  #       self.response.headers['Content-Disposition'] = "attachment; filename=#{zipname}"
  #       self.response.body = Enumerator.new do |out| # Enumerator is ruby 1.9
  #         while !zf.eof? do
  #           out << zf.read(4096)
  #         end
  #       end
  #     end
  #   end
  # end


  # # Zipfile generator
  # def generate_zip(&block)
  #   courses = Course.all
  #   # base temp dir
  #   temp_dir = Dir.mktempdir
  #   # path for zip we are about to create, I find that ruby zip needs to write to a real file
  #   zip_path = File.join(temp_dir, 'export.zip')
  #   Zip::ZipFile::open(zip_path, true) do |zipfile|
  #     courses.each do |course|
  #       zipfile.get_output_stream(course.CourseData.identifier) do |io|
  #         io.write course.CourseData.file.read
  #       end
  #     end
  #   end
  #   # yield the zipfile to the action
  #   block.call 'export.zip', zip_path
  # ensure
  #   # clean up the tempdir now!
  #   FileUtils.rm_rf temp_dir if temp_dir
  # end

  def download_file
    @grade = Grade.find(params[:id])
    @courses = @grade.courses
    send_file(@courses.CourseData.path,
              :disposition => 'zip',
              :url_based_filename => false)
  end
end
