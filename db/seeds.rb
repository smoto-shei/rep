# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[
  ['Bench Press', 'ベンチプレス'],
  ['Dumbbell Press', 'ダンベルプレス'],
  ['Incline Dumbbell Press', 'インクラインダンベルプレス'],
  ['Decline Dumbbell Press', 'ディクラインダンベルプレス'],
  ['Dumbell Fly', 'ダンベルフライ'],
  ['Chest Press', 'チェストプレス'],
  ['Butterfly', 'バタフライ'],
  ['Cable Crossover', 'ケーブルクロスオーバー'],
  ['Cable Fly', 'ケーブルフライ'],
  ['Push Up', 'プッシュアップ'],
  ['Dips', 'ディップス'],
  ['Shoulder Press', 'ショルダープレス'],
  ['Arnold Press', 'アーノルドプレス'],
  ['Front Raise', 'フロントレイズ'],
  ['Side Raise', 'サイドレイズ'],
  ['One Hand Rateral', 'ワンハンドラテラル'],
  ['Reardelt', 'リアデルト'],
  ['Cable Side Raise', 'ケーブルサイドレイズ'],
  ['Cable Front Raise', 'ケーブルフロントレイズ'],
  ['Barbell Curl', 'バーベルカール'],
  ['Preacher Curl', 'プリチャーカール'],
  ['French Press', 'フレンチプレス'],
  ['Narrow Grip Bench Press', 'ナローグリップベンチプレス'],
  ['Dumbbell Curl', 'ダンベルカール'],
  ['Hammer Curl', 'ハンマーカール'],
  ['One Hand Triceps Extension', 'ワンハンドトライセプスエクステンション'],
  ['Triceps Kickback', 'トライセプスキックバック'],
  ['Wrist Curl', 'リストカール'],
  ['Cable Curl', 'ケーブルカール'],
  ['Cable Triceps Extension', 'ケーブルトライセプスエクステンション'],
  ['Narrow Push Up', 'ナロープッシュアップ'],
  ['Deadlift', 'デッドリフト'],
  ['Bent Over Row', 'ベントオーバーロー'],
  ['Dumbbell Pull Over', 'ダンベルプルオーバー'],
  ['One Hand Rowing', 'ワンハンドローイング'],
  ['Lat Pull Down', 'ラットプルダウン'],
  ['Seated Rowing', 'シーテッドロー'],
  ['Chinning', 'チンニング'],
  ['Squat', 'スクワット'],
  ['Front Squat', 'フロントスクワット'],
  ['Front Lunge', 'フロントランジ'],
  ['Back Lunge', 'バックランジ'],
  ['Leg Press', 'レッグプレス'],
  ['Leg Extension', 'レッグエクステンション'],
  ['Leg Curl', 'レッグカール'],
  ['Treadmil', 'トレッドミル'],
  ['Bike', 'バイク'],
  ['Cross Trainer', 'クロストレーナー']
].each do |en_name, ja_name|
  Exercise.create!(
    { en_name: en_name, ja_name: ja_name }
  )
end

30.times do
  @user = User.create!(
    { nickname: Faker::}
  )