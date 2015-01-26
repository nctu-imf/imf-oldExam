
# 資財系帳號
create_account = User.create([name: '資財系帳號',
                email: 'imf@gmail.com', 
                password: 'imf', 
                password_confirmation: 'imf',
                admin: false,
                public:true])

# 最高權限帳號
create_account = User.create([name: '管理者No1',
                email: 'root@gmail.com', 
                password: '12345678', 
                password_confirmation: '12345678',
                admin: true,
                public: false])

# 一般使用者
create_account = User.create([name: '瓜瓜 ',
                email: 'gua@gmail.com', 
                password: 'guagua', 
                password_confirmation: 'guagua',
                admin: false,
                public: false])

Grade.create!(:name => "大一")
Grade.create!(:name => "大二")
Grade.create!(:name => "大三")
Grade.create!(:name => "大四")
Grade.create!(:name => "研究所")
Grade.create!(:name => "其他")

Semester.create!(:name => "上學期")
Semester.create!(:name => "下學期")
Semester.create!(:name => "暑修")
Semester.create!(:name => "其他")
