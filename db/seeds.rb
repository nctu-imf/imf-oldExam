
# 資財系帳號
create_account = User.create([name: '資財系帳號',
                email: 'imf@gmail.com', 
                password: 'imf', 
                password_confirmation: 'imf'])

# 最高權限帳號
create_account = User.create([name: '管理者No1',
                email: 'root@gmail.com', 
                password: '12345678', 
                password_confirmation: '12345678'])

Grade.create!(:name => "大一")
Grade.create!(:name => "大二")
Grade.create!(:name => "大三")
Grade.create!(:name => "大四")
Grade.create!(:name => "研究所")
Grade.create!(:name => "其他")

Semester.create!(:name => "上學期")
Semester.create!(:name => "下學期")
Semester.create!(:name => "暑修")
