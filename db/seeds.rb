require "date"

year = Date.today.year
IMAGE_URL = "https://picsum.photos/id/237/200/300"

#変更時にリセット
Movie.delete_all

def true_or_false?
  num = rand(0..1)
  if num == 0 
    return "false"
  else
    return "true"
  end
end

1.upto(50) do |n|
  Movie.create(
    id: "#{n}",
    name: "ユーザー#{n}",
    year: "#{year}",
    description: "説明#{n}",
    image_url: "#{IMAGE_URL}",
    is_showing: true_or_false?
  )
end