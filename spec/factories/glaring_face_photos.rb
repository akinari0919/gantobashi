FactoryBot.define do
  factory :glaring_face_photo do
    user { nil }
    image { "MyString" }
    face_score { 1 }
    battle_win_count { 1 }
  end
end
