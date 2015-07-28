#!/Users/swchoi06/.rvm/gems/ruby-2.2.1/bin/rails r

campuses = Campus.all
campuses.each do |campus|
  titles = ["치킨", "피자", "중국집", "한식/분식", "도시락/돈까스", "족발/보쌈", "냉면", "기타"]
  8.times do |i|
    a = Category.new
    a.title = titles[i]
    a.campus = campus

    reses = campus.restaurants.to_a
    reses.select! {|res| res.category == a.title }
    reses.each do |res|
      a.restaurants.push(res)
    end
    a.save
  end
end
