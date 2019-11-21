require 'rails_helper'

RSpec.describe User, type: :model do
  # 名、メール、パスワードがあれば有効な状態であること
  it "is valid with a name, email, and password" do
    user = User.new(
      name: "test",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
  end
  # 名前がなければ無効な状態であること
  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  # 重複したメールアドレスは無効な状態であること
  it "is invalid with a duplicate email address" do
    User.create(
      name: "tarou",
      email: "tester@example.com",
      password: "password"
    )
    user = User.new(
      name: "ryo",
      email: "tester@example.com",
      password: "password"
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
end
