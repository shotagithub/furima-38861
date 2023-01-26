require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録できる場合" do
      it "email、passwordとpassword_confirmation、nick_name、fimily_name、first_name、fimily_name_ruby、first_name_ruby、birth_dayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "family_nameは漢字、ひらがな、カタカナ、長音記号が登録できる" do
        family_name = "田なカー"
        expect(@user).to be_valid
      end
      it "first_nameは漢字、ひらがな、カタカナ、長音記号が登録できる" do
        first_name = "太ろウー"
        expect(@user).to be_valid
      end
      it "family_name_rubyはカタカナと長音記号のみであるとき登録できる" do
        family_name_ruby = "タナカー"
        expect(@user).to be_valid
      end
      it "first_name_rubyはカタカナと長音記号のみであるとき登録できる" do
        first_name_ruby = "タロウー"
        expect(@user).to be_valid
      end
    end
    context "新規登録できない場合" do
      it "nick_nameが空では登録できない" do
        @user.nick_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nick name can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが英字だけでは登録できない" do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "passwordが数字だけでは登録できない" do
        @user.password = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = "a1234"
        @user.password_confirmation = "a1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "passwordが129文字以上では登録できない" do
        @user.password =  Faker::Internet.password(min_length: 129)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end

      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = "a12345"
        @user.password_confirmation = "a123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "重複したemailが存在する場合は登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "emailは@を含まないと登録できない" do
        @user.email = "mailaddress"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "family_nameが空では登録できない" do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it "family_nameは記号は登録できない" do
        @user.family_name = "＊＋〜"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
      it "family_nameは英字は登録は登録できない" do
        @user.family_name = "tanaka"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
      it "family_nameは数字は登録は登録できない" do
        @user.family_name = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "first_nameは記号は登録できない" do
        @user.first_name = "＊＋〜"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it "first_nameは英字は登録は登録できない" do
        @user.first_name = "tanaka"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it "first_nameは数字は登録は登録できない" do
        @user.first_name = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
    end
  end
end
