tweets_list = {
    "Tweet 1" => {
      :year_completed => 1901
    },
    "Tweet 2" => {
      :year_completed => 1995
    },
    "Tweet 3" => {
      :year_completed => 2014
    },
    "Tweet 4" => {
      :year_completed => 1058
    },
    "Tweet 5" => {
      :year_completed => 2015
    },
    "Tweet 6" => {
      :year_completed => 1951
    },
    "Tweet 7" => {
      :year_completed => 1964
    },
    "Tweet 8" => {
      :year_completed => 1902
    },
    "Tweet 9" => {
      :year_completed => 1883
    }
  }

landmarks_list.each do |name, landmark_hash|
  p = Landmark.new
  p.name = name
  landmark_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end

figure_list = {
    "Billy The Kid" => {
    },
    "Mark Zuckerberg" => {
    },
    "Ada Lovelace" => {
    },
    "Linus Torvalds" => {
    }
  }
