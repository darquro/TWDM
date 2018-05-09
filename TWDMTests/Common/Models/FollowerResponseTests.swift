//
//  FollowerResponseTests.swift
//  TWDMTests
//
//  Created by yuki.kuroda on 2018/05/03.
//  Copyright © 2018年 darquro. All rights reserved.
//

import XCTest
import Foundation

class FollowerResponseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDecode() {
        let data = testJson.data(using: .utf8)!
        XCTAssertNoThrow(try FollowerResponse.decode(from: data))
        
        let response = try? FollowerResponse.decode(from: data)
        guard let res = response else {
            XCTAssertNotNil(response)
            return
        }
        
        XCTAssert(res.nextCursor == "1596630855141399282")
        XCTAssert(res.users.count == 3)
        
        guard let firstUser = res.users[0] else {
            XCTAssertNotNil(res.users[0])
            return
        }
        
        XCTAssert(firstUser.id == 873731947716984832)
        XCTAssert(firstUser.name == "けやニュー - 欅坂46ファンコミュニケーションアプリ◢͟￨⁴⁶")
        XCTAssert(firstUser.screenName == "keyanew_app")
        XCTAssert(firstUser.screenNameWithAtmark == "@keyanew_app")
        XCTAssert(firstUser.profileImageURLString == "https://pbs.twimg.com/profile_images/873735192480960512/hzJ06ZnN_normal.jpg")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    let testJson: String = """
{
  "users": [
    {
      "id": 873731947716984832,
      "id_str": "873731947716984832",
      "name": "\\u3051\\u3084\\u30cb\\u30e5\\u30fc - \\u6b05\\u574246\\u30d5\\u30a1\\u30f3\\u30b3\\u30df\\u30e5\\u30cb\\u30b1\\u30fc\\u30b7\\u30e7\\u30f3\\u30a2\\u30d7\\u30ea\\u25e2\\u035f\\uffe8\\u2074\\u2076",
      "screen_name": "keyanew_app",
      "location": "",
      "description": "\\u6b05\\u574246\\u30d5\\u30a1\\u30f3\\u30b3\\u30df\\u30e5\\u30cb\\u30b1\\u30fc\\u30b7\\u30e7\\u30f3\\u30a2\\u30d7\\u30ea",
      "url": "https:\\/\\/t.co\\/nLpoaNaa2A",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "https:\\/\\/t.co\\/nLpoaNaa2A",
              "expanded_url": "https:\\/\\/itunes.apple.com\\/jp\\/app\\/%E3%81%91%E3%82%84%E3%83%8B%E3%83%A5%E3%83%BC\\/id1319910970?mt=8",
              "display_url": "itunes.apple.com\\/jp\\/app\\/%E3%81%\\u2026",
              "indices": [
                0,
                23
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 328,
      "friends_count": 830,
      "listed_count": 0,
      "created_at": "Sun Jun 11 02:41:44 +0000 2017",
      "favourites_count": 0,
      "utc_offset": -25200,
      "time_zone": "Pacific Time (US & Canada)",
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 2,
      "lang": "ja",
      "status": {
        "created_at": "Tue Dec 19 00:43:31 +0000 2017",
        "id": 942918282696257536,
        "id_str": "942918282696257536",
        "text": "\\u6b05\\u574246\\u30d5\\u30a1\\u30f3\\u30b3\\u30df\\u30e5\\u30cb\\u30b1\\u30fc\\u30b7\\u30e7\\u30f3\\u30a2\\u30d7\\u30ea\\u300e\\u3051\\u3084\\u30cb\\u30e5\\u30fc\\u300f \\u30c0\\u30a6\\u30f3\\u30ed\\u30fc\\u30c9\\u306f\\u3053\\u3061\\u3089\\uff01\\uff01 #\\u6b05\\u574246 #\\u3051\\u3084\\u304d\\u574246 https:\\/\\/t.co\\/9crwajwq13%\\u2026",
        "truncated": false,
        "entities": {
          "hashtags": [
            {
              "text": "\\u6b05\\u574246",
              "indices": [
                40,
                45
              ]
            },
            {
              "text": "\\u3051\\u3084\\u304d\\u574246",
              "indices": [
                46,
                53
              ]
            }
          ],
          "symbols": [],
          "user_mentions": [],
          "urls": [
            {
              "url": "https:\\/\\/t.co\\/9crwajwq13",
              "expanded_url": "http:\\/\\/itunes.apple.com\\/jp\\/app\\/%E3%81",
              "display_url": "itunes.apple.com\\/jp\\/app\\/%E3%81",
              "indices": [
                54,
                77
              ]
            }
          ]
        },
        "source": "\\u003ca href=\\"http:\\/\\/twitter.com\\/download\\/iphone\\" rel=\\"nofollow\\"\\u003eTwitter for iPhone\\u003c\\/a\\u003e",
        "in_reply_to_status_id": null,
        "in_reply_to_status_id_str": null,
        "in_reply_to_user_id": null,
        "in_reply_to_user_id_str": null,
        "in_reply_to_screen_name": null,
        "geo": null,
        "coordinates": null,
        "place": null,
        "contributors": null,
        "is_quote_status": false,
        "retweet_count": 0,
        "favorite_count": 0,
        "favorited": false,
        "retweeted": false,
        "possibly_sensitive": false,
        "lang": "ja"
      },
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "000000",
      "profile_background_image_url": "http:\\/\\/abs.twimg.com\\/images\\/themes\\/theme1\\/bg.png",
      "profile_background_image_url_https": "https:\\/\\/abs.twimg.com\\/images\\/themes\\/theme1\\/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http:\\/\\/pbs.twimg.com\\/profile_images\\/873735192480960512\\/hzJ06ZnN_normal.jpg",
      "profile_image_url_https": "https:\\/\\/pbs.twimg.com\\/profile_images\\/873735192480960512\\/hzJ06ZnN_normal.jpg",
      "profile_banner_url": "https:\\/\\/pbs.twimg.com\\/profile_banners\\/873731947716984832\\/1513644939",
      "profile_link_color": "7FDBB6",
      "profile_sidebar_border_color": "000000",
      "profile_sidebar_fill_color": "000000",
      "profile_text_color": "000000",
      "profile_use_background_image": false,
      "has_extended_profile": false,
      "default_profile": false,
      "default_profile_image": false,
      "following": true,
      "live_following": false,
      "follow_request_sent": false,
      "notifications": false,
      "muting": false,
      "blocking": false,
      "blocked_by": false,
      "translator_type": "none"
    },
    {
      "id": 191280685,
      "id_str": "191280685",
      "name": "gremito",
      "screen_name": "grem_ito",
      "location": "",
      "description": "\\u6771\\u4eac\\u516b\\u8010\\u3084\\u3063\\u3066\\u307e\\u3059\\u3002",
      "url": "https:\\/\\/t.co\\/z2mXUUE6Sv",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "https:\\/\\/t.co\\/z2mXUUE6Sv",
              "expanded_url": "https:\\/\\/tech.drecom.co.jp\\/event_hachijikan\\/",
              "display_url": "tech.drecom.co.jp\\/event_hachijik\\u2026",
              "indices": [
                0,
                23
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 203,
      "friends_count": 346,
      "listed_count": 10,
      "created_at": "Thu Sep 16 01:49:53 +0000 2010",
      "favourites_count": 3336,
      "utc_offset": 32400,
      "time_zone": "Tokyo",
      "geo_enabled": true,
      "verified": false,
      "statuses_count": 5177,
      "lang": "ja",
      "status": {
        "created_at": "Wed May 02 06:35:01 +0000 2018",
        "id": 991566712251142144,
        "id_str": "991566712251142144",
        "text": "\\u4f1a\\u793e\\u306e\\u30ab\\u30d5\\u30a7\\u3067ELLEGARDEN\\u304c\\u6d41\\u308c\\u3066\\u3044\\u305f\\u304b\\u3089\\u901f\\u653b\\u4f5c\\u696d\\u7528BGM\\u3092\\u30a8\\u30eb\\u30ec\\u306b\\u3057\\u305f\\u308fw",
        "truncated": false,
        "entities": {
          "hashtags": [],
          "symbols": [],
          "user_mentions": [],
          "urls": []
        },
        "source": "\\u003ca href=\\"http:\\/\\/twitter.com\\" rel=\\"nofollow\\"\\u003eTwitter Web Client\\u003c\\/a\\u003e",
        "in_reply_to_status_id": null,
        "in_reply_to_status_id_str": null,
        "in_reply_to_user_id": null,
        "in_reply_to_user_id_str": null,
        "in_reply_to_screen_name": null,
        "geo": null,
        "coordinates": null,
        "place": null,
        "contributors": null,
        "is_quote_status": false,
        "retweet_count": 0,
        "favorite_count": 0,
        "favorited": false,
        "retweeted": false,
        "lang": "ja"
      },
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http:\\/\\/pbs.twimg.com\\/profile_background_images\\/389604676\\/IMG_2625.JPG",
      "profile_background_image_url_https": "https:\\/\\/pbs.twimg.com\\/profile_background_images\\/389604676\\/IMG_2625.JPG",
      "profile_background_tile": true,
      "profile_image_url": "http:\\/\\/pbs.twimg.com\\/profile_images\\/746194557528735748\\/nOOjfscZ_normal.jpg",
      "profile_image_url_https": "https:\\/\\/pbs.twimg.com\\/profile_images\\/746194557528735748\\/nOOjfscZ_normal.jpg",
      "profile_banner_url": "https:\\/\\/pbs.twimg.com\\/profile_banners\\/191280685\\/1460373529",
      "profile_link_color": "89C9FA",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": true,
      "default_profile": false,
      "default_profile_image": false,
      "following": true,
      "live_following": false,
      "follow_request_sent": false,
      "notifications": false,
      "muting": false,
      "blocking": false,
      "blocked_by": false,
      "translator_type": "none"
    },
    {
      "id": 230099968,
      "id_str": "230099968",
      "name": "\\u3060\\u3044\\u305d\\u3093",
      "screen_name": "daidai3110",
      "location": "",
      "description": "Swift\\/Rails\\/Angular\\/node\\/kotlin\\/boowy\\/\\u6700\\u8fd1Firebase",
      "url": null,
      "entities": {
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 125,
      "friends_count": 270,
      "listed_count": 0,
      "created_at": "Fri Dec 24 08:00:27 +0000 2010",
      "favourites_count": 284,
      "utc_offset": 32400,
      "time_zone": "Tokyo",
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 1091,
      "lang": "ja",
      "status": {
        "created_at": "Tue May 01 12:52:45 +0000 2018",
        "id": 991299385324535808,
        "id_str": "991299385324535808",
        "text": "\\u5927\\u8f14\\u897f\\u6b66\\u623b\\u3063\\u3066\\u304d\\u3066\\u304f\\u308c\\u306a\\u3044\\u304b\\u306a\\u30fc\\u7b11",
        "truncated": false,
        "entities": {
          "hashtags": [],
          "symbols": [],
          "user_mentions": [],
          "urls": []
        },
        "source": "\\u003ca href=\\"http:\\/\\/twitter.com\\/download\\/iphone\\" rel=\\"nofollow\\"\\u003eTwitter for iPhone\\u003c\\/a\\u003e",
        "in_reply_to_status_id": null,
        "in_reply_to_status_id_str": null,
        "in_reply_to_user_id": null,
        "in_reply_to_user_id_str": null,
        "in_reply_to_screen_name": null,
        "geo": null,
        "coordinates": null,
        "place": null,
        "contributors": null,
        "is_quote_status": false,
        "retweet_count": 0,
        "favorite_count": 1,
        "favorited": false,
        "retweeted": false,
        "lang": "ja"
      },
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http:\\/\\/abs.twimg.com\\/images\\/themes\\/theme1\\/bg.png",
      "profile_background_image_url_https": "https:\\/\\/abs.twimg.com\\/images\\/themes\\/theme1\\/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http:\\/\\/pbs.twimg.com\\/profile_images\\/711790263740411904\\/KtmyeHGE_normal.jpg",
      "profile_image_url_https": "https:\\/\\/pbs.twimg.com\\/profile_images\\/711790263740411904\\/KtmyeHGE_normal.jpg",
      "profile_link_color": "1DA1F2",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": false,
      "default_profile": true,
      "default_profile_image": false,
      "following": false,
      "live_following": false,
      "follow_request_sent": false,
      "notifications": false,
      "muting": false,
      "blocking": false,
      "blocked_by": false,
      "translator_type": "none"
    }
  ],
  "next_cursor": 1596630855141399282,
  "next_cursor_str": "1596630855141399282",
  "previous_cursor": 0,
  "previous_cursor_str": "0"
}
"""
    
}
