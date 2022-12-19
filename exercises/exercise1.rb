irb(main):004:0> Brewery.create name: "BrewDog", year: 2007
  TRANSACTION (0.1ms)  begin transaction
  Brewery Create (1.4ms)  INSERT INTO "breweries" ("name", "year", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "BrewDog"], ["year", 2007], ["created_at", "2022-12-19 13:44:16.892249"], ["updated_at", "2022-12-19 13:44:16.892249"]]
  TRANSACTION (6.3ms)  commit transaction
=>
#<Brewery:0x000002b8659f3010
 id: 4,
 name: "BrewDog",
 year: 2007,
 created_at: Mon, 19 Dec 2022 13:44:16.892249000 UTC +00:00,
 updated_at: Mon, 19 Dec 2022 13:44:16.892249000 UTC +00:00>
irb(main):005:0> brewdog = Brewery.find_by name: "BrewDog"
  Brewery Load (0.3ms)  SELECT "breweries".* FROM "breweries" WHERE "breweries"."name" = ? LIMIT ?  [["name", "BrewDog"], ["LIMIT", 1]]
=>
#<Brewery:0x000002b866c93e90
...
irb(main):006:0> Beer.create name: "Punk IPA", style: "IPA", brewery_id: brewdog.id
  TRANSACTION (0.1ms)  begin transaction
  Brewery Load (0.4ms)  SELECT "breweries".* FROM "breweries" WHERE "breweries"."id" = ? LIMIT ?  [["id", 4], ["LIMIT", 1]]
  Beer Create (1.3ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Punk IPA"], ["style", "IPA"], ["brewery_id", 4], ["created_at", "2022-12-19 13:46:21.361891"], ["updated_at", "2022-12-19 13:46:21.361891"]]
  TRANSACTION (8.4ms)  commit transaction
=>
#<Beer:0x000002b867baf820
 id: 8,
 name: "Punk IPA",
 style: "IPA",
 brewery_id: 4,
 created_at: Mon, 19 Dec 2022 13:46:21.361891000 UTC +00:00,
 updated_at: Mon, 19 Dec 2022 13:46:21.361891000 UTC +00:00>
irb(main):007:0> Beer.create name: "Nanny State", style: "lowalcohol", brewery_id: brewdog.id
  TRANSACTION (0.1ms)  begin transaction
  Brewery Load (0.2ms)  SELECT "breweries".* FROM "breweries" WHERE "breweries"."id" = ? LIMIT ?  [["id", 4], ["LIMIT", 1]]
  Beer Create (3.1ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Nanny State"], ["style", "lowalcohol"], ["brewery_id", 4], ["created_at", "2022-12-19 13:47:35.721975"], ["updated_at", "2022-12-19 13:47:35.721975"]]
  TRANSACTION (5.5ms)  commit transaction
=>
#<Beer:0x000002b867054070
 id: 9,
 name: "Nanny State",
 style: "lowalcohol",
 brewery_id: 4,
 created_at: Mon, 19 Dec 2022 13:47:35.721975000 UTC +00:00,
 updated_at: Mon, 19 Dec 2022 13:47:35.721975000 UTC +00:00>
 irb(main):011:0> nanny = Beer.find_by name: "Nanny State"
  Beer Load (0.3ms)  SELECT "beers".* FROM "beers" WHERE "beers"."name" = ? LIMIT ?  [["name", "Nanny State"], ["LIMIT", 1]]
=>
#<Beer:0x000002b8661313b8
...
irb(main):012:0> punk = Beer.find_by name: "Punk IPA"
  Beer Load (0.3ms)  SELECT "beers".* FROM "beers" WHERE "beers"."name" = ? LIMIT ?  [["name", "Punk IPA"], ["LIMIT", 1]]
=>
#<Beer:0x000002b8674e1b10
...
irb(main):013:0> Rating.create score: 15, beer_id: punk.id
  TRANSACTION (0.1ms)  begin transaction
  Beer Load (0.3ms)  SELECT "beers".* FROM "beers" WHERE "beers"."id" = ? LIMIT ?  [["id", 8], ["LIMIT", 1]]
  Rating Create (1.0ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 15], ["beer_id", 8], ["created_at", "2022-12-19 13:53:33.037342"], ["updated_at", "2022-12-19 13:53:33.037342"]]
  TRANSACTION (7.0ms)  commit transaction
=>
#<Rating:0x000002b867a9a098
 id: 1,
 score: 15,
 beer_id: 8,
 created_at: Mon, 19 Dec 2022 13:53:33.037342000 UTC +00:00,
 updated_at: Mon, 19 Dec 2022 13:53:33.037342000 UTC +00:00>
irb(main):014:0> Rating.create score: 10, beer_id: punk.id
  TRANSACTION (0.1ms)  begin transaction
  Beer Load (0.2ms)  SELECT "beers".* FROM "beers" WHERE "beers"."id" = ? LIMIT ?  [["id", 8], ["LIMIT", 1]]
  Rating Create (1.2ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 10], ["beer_id", 8], ["created_at", "2022-12-19 13:54:11.851354"], ["updated_at", "2022-12-19 13:54:11.851354"]]
  TRANSACTION (6.5ms)  commit transaction
=>
#<Rating:0x000002b8675183e0
 id: 2,
 score: 10,
 beer_id: 8,
 created_at: Mon, 19 Dec 2022 13:54:11.851354000 UTC +00:00,
 updated_at: Mon, 19 Dec 2022 13:54:11.851354000 UTC +00:00>
irb(main):016:0> Rating.create score: 4, beer_id: nanny.id
  TRANSACTION (0.1ms)  begin transaction
  Beer Load (0.2ms)  SELECT "beers".* FROM "beers" WHERE "beers"."id" = ? LIMIT ?  [["id", 9], ["LIMIT", 1]]
  Rating Create (1.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 4], ["beer_id", 9], ["created_at", "2022-12-19 13:54:37.456936"], ["updated_at", "2022-12-19 13:54:37.456936"]]
  TRANSACTION (6.3ms)  commit transaction
=>
#<Rating:0x000002b866455738
 id: 3,
 score: 4,
 beer_id: 9,
 created_at: Mon, 19 Dec 2022 13:54:37.456936000 UTC +00:00,
 updated_at: Mon, 19 Dec 2022 13:54:37.456936000 UTC +00:00>
irb(main):017:0> Rating.create score: 8, beer_id: nanny.id
  TRANSACTION (0.1ms)  begin transaction
  Beer Load (0.2ms)  SELECT "beers".* FROM "beers" WHERE "beers"."id" = ? LIMIT ?  [["id", 9], ["LIMIT", 1]]
  Rating Create (1.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 8], ["beer_id", 9], ["created_at", "2022-12-19 13:54:51.265068"], ["updated_at", "2022-12-19 13:54:51.265068"]]
  TRANSACTION (5.9ms)  commit transaction
=>
#<Rating:0x000002b8645613e0
 id: 4,
 score: 8,
 beer_id: 9,
 created_at: Mon, 19 Dec 2022 13:54:51.265068000 UTC +00:00,
 updated_at: Mon, 19 Dec 2022 13:54:51.265068000 UTC +00:00>
irb(main):018:0> Rating.create score: 14, beer_id: nanny.id
  TRANSACTION (0.1ms)  begin transaction
  Beer Load (0.2ms)  SELECT "beers".* FROM "beers" WHERE "beers"."id" = ? LIMIT ?  [["id", 9], ["LIMIT", 1]]
  Rating Create (1.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 14], ["beer_id", 9], ["created_at", "2022-12-19 13:54:57.787546"], ["updated_at", "2022-12-19 13:54:57.787546"]]
  TRANSACTION (6.3ms)  commit transaction
=>
#<Rating:0x000002b8677df588
 id: 5,
 score: 14,
 beer_id: 9,
 created_at: Mon, 19 Dec 2022 13:54:57.787546000 UTC +00:00,
 updated_at: Mon, 19 Dec 2022 13:54:57.787546000 UTC +00:00>