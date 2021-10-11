# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


level_settings = LevelSetting.create([{level: 2, thresold: 50}, {level: 3, thresold: 150},
                                      {level: 3, thresold: 250},{level: 4, thresold: 400},
                                      {level: 5, thresold: 600},{level: 6, thresold: 900},
                                      {level: 7, thresold: 1300},{level: 8, thresold: 1800},
                                      {level: 9, thresold: 2400},{level: 10, thresold: 3100},
                                      {level: 11, thresold: 3900},{level: 12, thresold: 4800},
                                      {level: 13, thresold: 5800},{level: 14, thresold: 6900},
                                      {level: 15, thresold: 7100},{level: 16, thresold: 8400},
                                      {level: 17, thresold: 9800},{level: 18, thresold: 12300},
                                      {level: 19, thresold: 13900},{level: 20, thresold: 15000}])