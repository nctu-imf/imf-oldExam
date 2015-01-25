class GradeController < ApplicationController
  before_action :authenticate_user!
  require 'zip'

  def show
    @grades = Grade.all
    @grade = Grade.find(params[:id])
    @courses = @grade.courses.recent.paginate(:per_page => 15, :page => params[:page])
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
  #   @grade = Grade.find(params[:id])
  #   @courses = @grade.courses

  #   # base temp dir
  #   temp_dir = Dir.mktmpdir
  #   # path for zip we are about to create, I find that ruby zip needs to write to a real file
  #   zip_path = File.join(temp_dir, 'export.zip')
  #   Zip::File::open(zip_path, true) do |zipfile|
  #     @courses.each do |course|
  #       zipfile.get_output_stream(course.data.identifier) do |io|
  #         io.write course.data.file.read
  #       end
  #     end
  #   end
  #   # yield the zipfile to the action
  #   block.call 'export.zip', zip_path
  #   ensure
  #     # clean up the tempdir now!
  #     FileUtils.rm_rf temp_dir if temp_dir
  # end

  def download
    # @grade = Grade.find(params[:id])
    # @courses = @grade.courses

    # input_filenames = @courses.first.data.path

    # zipfile_name = "archive.zip"

    # Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
    #   input_filenames.each do |filename|
    #     zipfile.add(filename, filename)
    #   end
    # end

    # send_file(folder,
    #           :disposition => 'zip',
    #           :url_based_filename => false)
  end
end
