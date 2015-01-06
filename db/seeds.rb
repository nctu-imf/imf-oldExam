
create_account = User.create([email: 'example@gmail.com', 
                password: '12345678', 
                password_confirmation: '12345678'])

category_list = ["期中考", "期末考", "小考", "上機考"]

create_course = for i in 1..10 do
          Course.create!([
                name: "種子建立的第#{i}門課", 
                category: "#{category_list[rand(category_list.length)]}",
                year: "#{2010 + rand(5)}", 
                grade: "#{1 + rand(3)}", 
                teacher: "教授NO.#{i}",
                note: "備註#{i}"
              ])
        end
