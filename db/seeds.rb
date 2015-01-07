
# 資財系帳號
create_account = User.create([email: 'imf@gmail.com', 
                password: 'imf', 
                password_confirmation: 'imf'])

# 最高權限帳號
create_account = User.create([email: 'root@gmail.com', 
                password: '12345678', 
                password_confirmation: '12345678'])