
CNNNews = {}
CNNNews.__index = CNNNews

function CNNNews:new()
	newObj = {
		categories = {
			top = 'http://rss.cnn.com/rss/edition.rss',
			world = 'http://rss.cnn.com/rss/edition_world.rss',
			africa = 'http://rss.cnn.com/rss/edition_africa.rss',
			americas = 'http://rss.cnn.com/rss/edition_americas.rss',
			asia = 'http://rss.cnn.com/rss/edition_asia.rss',
			europe = 'http://rss.cnn.com/rss/edition_europe.rss',
			meast = 'http://rss.cnn.com/rss/edition_meast.rss',
			us = 'http://rss.cnn.com/rss/edition_us.rss',
			money = 'http://rss.cnn.com/rss/money_news_international.rss',
			techno = 'http://rss.cnn.com/rss/edition_technology.rss',
			space = 'http://rss.cnn.com/rss/edition_space.rss',
			entertainment = 'http://rss.cnn.com/rss/edition_entertainment.rss',
			sports = 'http://rss.cnn.com/rss/edition_sport.rss',
			football = 'http://rss.cnn.com/rss/edition_football.rss',
			golf = 'http://rss.cnn.com/rss/edition_golf.rss',
			motor = 'http://rss.cnn.com/rss/edition_motorsport.rss',
			tennis = 'http://rss.cnn.com/rss/edition_tennis.rss',
			video = 'http://rss.cnn.com/rss/cnn_freevideo.rss',
			latest = 'http://rss.cnn.com/rss/cnn_latest.rss'

		}
	}
  self.__index = self
  return setmetatable(newObj, self)
end