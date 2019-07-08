data_array = Array.new
#track_id = "campusdal.airbridge.io/"
main_image_url = "image_url"
Restaurant.all.each do |res|
  puts res.name

  res_hash = Hash.new
  #res_hash["subPath"] = track_id

  categories = res.categories
  # Indicies
  a = Hash.new
  b = Hash.new
  b["restaurantId"] = res.id.to_s
  if categories == nil || categories == [] || categories[0] == nil
    puts "Error on restaurant"
    puts res.name + " " + res.id.to_s
    b["campusName"] = "서울대학교"
  else
    b["campusName"] = categories[0].campus.name_kor
  end
  a["android"] = b
  a["ios"] = b
  res_hash["indicies"] = a

  # Title and description
  res_hash["title"] = res.name
  if categories == nil || categories == [] || categories[0] == nil
    puts "Error on restaurant"
    puts res.name + " " + res.id.to_s
    next
  end
  
  cat = categories[0]
  if cat.title == "기타"
    cat.title = "맛집"
  end
  res_hash["description"] = cat.campus.name_kor_short + " 근처 " + cat.title
  if res_hash["description"] == nil
    puts "Error on description"
    puts res.name + " " + res.id
  end

  # imageUrl
  res_hash["imageUrl"] = main_image_url

  # hiddenParams
  res_hash["hiddenParams"] = Hash.new
  res_hash["hiddenParams"]["totalCalls"] = res.total_number_of_calls


  # Cards
  cards = Array.new
  
  # Main Card
  card = Hash.new
  card["cardType"] = "mainCard"
  # contents
  content_hash = Hash.new
  content_hash["mainColor"] = "FB7010"
  content_hash["mainImageUrl"] = main_image_url
  content_hash["category"] = cat.title
  content_hash["count"] = res.total_number_of_bads + res.total_number_of_goods
  content_hash["countLabel"] = "개 평가"
  content_hash["mainTag"] = res_hash["description"]
  content_hash["mainTitle"] = res.name
  content_hash["valueLabel"] = "재주문율"
  if res.retention == nil
    content_hash["value"] = "0%"
  else
    content_hash["value"] = (res.retention*100).round(2).to_s + "%"
  end

  card["contents"] = content_hash
  cards.push(card)

  # iconBulletCard
  card  = Hash.new
  card["cardType"] = "iconBulletCard"
  # contents
  content_array = Array.new
  a = Hash.new
  array = Array.new
  component_hash = Hash.new
  component_hash["iconName"] = "time" #?????????
  component_hash["text"] = "주중 " + res.opening_hours.to_i.to_s + ":00-" + res.closing_hours.to_i.to_s + ":00"
  array.push(component_hash)

  if res.minimum_price != nil and res.minimum_price != 0 
    component_hash = Hash.new
    component_hash["iconName"] = "ride" #???????
    component_hash["text"] = res.minimum_price.to_s + "원 이상 배달 가능"
    array.push(component_hash)
  end
  
  card["contents"] = array

  cards.push(card)

  # textCard
  if res.notice != nil and res.notice != ""
    notices = res.notice.gsub("\r", '').split(/[\n]/).select{|c| c!=""}
    card = Hash.new
    card["cardType"] = "textCard"
    card["contents"] = Hash.new
    card["contents"]["textType"] = "list"
    card["contents"]["text"] = notices

    cards.push(card)
  end

  # twoColumnDivisionCard
  card = Hash.new
  card["cardType"] = "twoColumnDivisionCard"
  # contents
  content_array = Array.new
  content_hash = Hash.new
  content_hash["divisionName"] = "메뉴 정보"
  content_hash["components"] = Array.new
  cnt = [res.menus.count, 20].min
  cnt.times do |i|
    a = Hash.new
    a["firstColText"] = res.menus[i].name
    if res.menus[i].price == 0 || res.menus[i].price == nil
      a["secondColText"] = ""
    else
      a["secondColText"] = res.menus[i].price.to_s
    end
    content_hash["components"].push(a)
  end
  content_array.push(content_hash)
  card["contents"] = content_array

  cards.push(card)

  #attractingCard
  card = Hash.new
  card["cardType"] = "attractingCard"
  card["contents"] = Hash.new
  card["contents"]["attractingTitle"] = "주문전화번호"
  card["contents"]["attractingDescription"] = "전화번호는 캠퍼스달앱에서 확인할 수 있습니다"
  card["contents"]["actionVerb"] = "주문하기!"
  cards.push(card)

  res_hash["cards"] = cards
  data_array.push(res_hash)
end

File.open("public/test.json","w") do |f|
  f.write(JSON.generate(data_array))
end
